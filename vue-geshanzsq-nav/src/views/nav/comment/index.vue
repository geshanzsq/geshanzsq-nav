<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="评论内容" prop="commentContent">
        <el-input
            v-model="queryParams.commentContent"
            placeholder="请输入评论内容"
            clearable
            size="small"
            @input="getList"
            @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="状态" prop="status">
        <el-select v-model="queryParams.status" placeholder="请选择状态" clearable size="small" @change="getList">
          <el-option
              v-for="dict in statusOptions"
              :key="dict.dictValue"
              :label="dict.dictLabel"
              :value="dict.dictValue"
          />
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="cyan" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button
            type="primary"
            icon="el-icon-success"
            :disabled="multiple"
            size="mini"
            @click="handlePassComment"
            v-hasPermi="['nav:comment:pass']"
        >通过</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
            type="info"
            :disabled="multiple"
            icon="el-icon-close"
            size="mini"
            @click="handleNoPassComment"
            v-hasPermi="['nav:comment:noPass']"
        >不通过</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="commentList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="序号" align="center" type="index" />
      <el-table-column label="评论内容" align="center" prop="commentContent">
        <template slot-scope="scope">
          <span v-html="scope.row.commentContent"></span>
        </template>
      </el-table-column>
      <el-table-column label="评论人" align="center" prop="createBy"/>
      <el-table-column label="昵称" align="center" prop="nickName"/>
      <el-table-column label="邮箱" align="center" prop="email"/>
      <el-table-column label="状态" align="center" prop="status" :formatter="statusFormat" />
      <el-table-column label="评论时间" prop="createTime">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.createTime) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="审核时间" prop="updateTime">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.updateTime) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="是否置顶" align="center" prop="sticky">
        <template slot-scope="scope">
          <el-tag v-if="scope.row.sticky == '1'" type="primary" size="small" effect="dark">置顶</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="不通过理由" align="center" prop="reason" />
      <el-table-column label="操作" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
              size="mini"
              type="text"
              icon="el-icon-success"
              @click="handlePassComment(scope.row)"
              v-hasPermi="['nav:comment:pass']"
          >通过</el-button>
          <el-button
              size="mini"
              type="text"
              icon="el-icon-error"
              @click="handleNoPassComment(scope.row)"
              v-hasPermi="['nav:comment:noPass']"
          >不通过</el-button>
          <el-button
              size="mini"
              type="text"
              icon="el-icon-top"
              v-if="scope.row.sticky != '1' && scope.row.status == '1'"
              @click="handleStickyComment(scope.row)"
              v-hasPermi="['nav:comment:noPass']"
          >置顶</el-button>
          <el-button
              size="mini"
              type="text"
              icon="el-icon-bottom"
              v-if="scope.row.sticky == '1' && scope.row.status == '1'"
              @click="handleCancelStickyComment(scope.row)"
              v-hasPermi="['nav:comment:noPass']"
          >取消置顶</el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination
        v-show="total>0"
        :total="total"
        :page.sync="queryParams.pageNum"
        :limit.sync="queryParams.pageSize"
        @pagination="getList"
    />

    <el-dialog title="填写不通过理由" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" >
        <el-form-item prop="reason">
          <el-input type="textarea" :rows="3" v-model="form.reason" placeholder="请输入不通过理由" />
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>

  </div>
</template>

<script>
  import { listComment, passComment, noPassComment,stickyComment,cancelStickyComment} from "@/api/nav/comment";

  export default {
    name: "NavComment",
    components: {
    },
    data() {
      return {
        // 遮罩层
        loading: true,
        // 选中数组
        ids: [],
        // 非单个禁用
        single: true,
        // 非多个禁用
        multiple: true,
        // 显示搜索条件
        showSearch: true,
        // 总条数
        total: 0,
        // 评论表格数据
        commentList: [],
        // 状态字典
        statusOptions: [],
        // 查询参数
        queryParams: {
          pageNum: 1,
          pageSize: 10,
          commentContent: null,
          status: '0'
        },
        // 是否显示弹出层
        open: false,
        // 不通过
        form: {
          reason: '',
          commentIds: undefined
        }
      };
    },
    created() {
      this.getList();
      this.getDicts("nav_comment_status").then(response => {
        this.statusOptions = response.data;
      });
    },
    methods: {
      /** 查询评论列表 */
      getList() {
        this.loading = true;
        listComment(this.queryParams).then(response => {
          this.commentList = response.rows;
          this.total = response.total;
          this.loading = false;
        });
      },
      // 状态字典翻译
      statusFormat(row, column) {
        return this.selectDictLabel(this.statusOptions, row.status);
      },

      /** 搜索按钮操作 */
      handleQuery() {
        this.queryParams.pageNum = 1;
        this.getList();
      },
      /** 重置按钮操作 */
      resetQuery() {
        this.resetForm("queryForm");
        this.handleQuery();
      },
      // 多选框选中数据
      handleSelectionChange(selection) {
        this.ids = selection.map(item => item.commentId)
        this.single = selection.length!==1
        this.multiple = !selection.length
      },
      // 通过点击事件
      handlePassComment(row) {
        let commentIds = []
        if (row.commentId == undefined) {
          commentIds = this.ids;
        } else {
          commentIds.push(row.commentId)
        }
        passComment({commentIds : commentIds}).then(response => {
          if (response.code == 200) {
            this.msgSuccess('评论通过成功！');
            this.getList();
          }
        })
      },
      // 不通过点击事件
      handleNoPassComment(row) {
        this.form.commentIds = [];
        if (row.commentId == undefined) {
          this.form.commentIds = this.ids;
        } else {
          this.form.commentIds.push(row.commentId)
        }
        this.open = true;
      },
      // 取消按钮
      cancel() {
        this.open = false;
        this.reset();
      },
      /** 提交按钮 */
      submitForm() {
        noPassComment(this.form).then(response => {
          if (response.code == 200) {
            this.msgSuccess('不通过评论成功！');
            this.open = false;
            this.getList();
          }
        })
      },
      // 置顶操作
      handleStickyComment(row) {
        stickyComment(row.commentId).then(response => {
          if (response.code == 200) {
            this.msgSuccess('置顶成功！')
            this.getList();
          }
        })
      },
      // 取消置顶
      handleCancelStickyComment(row) {
        cancelStickyComment(row.commentId).then(response => {
          if (response.code == 200) {
            this.msgSuccess('取消置顶成功！')
            this.getList();
          }
        })
      }

    }
  };
</script>
