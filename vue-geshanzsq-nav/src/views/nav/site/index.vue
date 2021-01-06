<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" :inline="true" v-show="showSearch">
      <el-form-item label="网站名称描述" prop="siteName">
        <el-input
            v-model="queryParams.siteName"
            placeholder="请输入网站名称或描述"
            clearable
            size="small"
            @input="handleQuery"
            @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="菜单">
        <div style="width: 200px">
          <treeselect
              v-model="queryParams.menuId"
              :options="menuOptions"
              :disable-branch-nodes="true"
              :show-count="true"
              @input="handleQuery"
              placeholder="请选择导航菜单" />
        </div>
      </el-form-item>
      <el-form-item label="状态" prop="status">
        <el-select v-model="queryParams.status" placeholder="网站状态" clearable size="small" @change="handleQuery">
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
          icon="el-icon-plus"
          size="mini"
          @click="handleAdd"
          v-hasPermi="['nav:site:add']"
        >新增</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-row :gutter="24" style="margin-top: 20px" v-loading="loading">
      <el-col :sm="6" :sx="24" style="margin-bottom: 15px" :key="site.siteId" v-for="site in siteList">
        <div style="position: relative"
             @mouseenter="handleSiteCardMouseEnter(site.siteId)"
             @mouseleave="handleSiteCardMouseLeave">
          <div v-show="site.siteId == siteId" class="site-card-edit" @click.stop="handleUpdate(site)"><i class="el-icon-edit"></i></div>
          <div v-show="site.siteId == siteId" class="site-card-close" @click.stop="handleDelete(site)"><i class="el-icon-close"></i></div>
        <site-card :site="site" :isSys="true" style="height: 140px" :class="site.siteId == siteId ? 'system-site-card' : ''">
          <div slot="card-footer">
            <div>
              <i class="el-icon-view card-footer-icon"> {{site.clickCount}} </i>
              <i class="el-icon-sort card-footer-icon"> {{site.orderNum}} </i>
            </div>
            <div class="belong-menu">所属菜单：{{site.menuName}}</div>
          </div>
        </site-card>
        </div>
      </el-col>
    </el-row>

    <div v-if="siteList.length == 0"><el-divider>暂无数据！</el-divider></div>

    <pagination
        v-show="total>0"
        :total="total"
        :page.sync="queryParams.pageNum"
        :limit.sync="queryParams.pageSize"
        :pageSizes="[12,16,20,24]"
        @pagination="getList"
    />

    <!-- 添加或修改导航网站信息对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="所属菜单" prop="menuId">
          <treeselect v-model="form.menuId"
                      :options="menuOptions"
                      :disable-branch-nodes="true"
                      :show-count="true"
                      :clearable="false"
                      @input="handleAddEditSelectMenu"
                      placeholder="请选择导航菜单" />
        </el-form-item>
        <el-form-item label="网站名称" prop="siteName">
          <el-input v-model="form.siteName" placeholder="请输入网站名称" />
        </el-form-item>
        <el-form-item label="网站地址" prop="siteUrl">
          <el-input v-model="form.siteUrl" placeholder="请输入网站地址" />
        </el-form-item>
        <el-form-item label="网站描述" prop="siteDescription">
          <el-input v-model="form.siteDescription" placeholder="请输入网站描述" />
        </el-form-item>
        <el-form-item label="显示顺序" prop="orderNum">
          <el-input-number v-model="form.orderNum" placeholder="请输入显示顺序" controls-position="right" :min="0"/>
        </el-form-item>
        <el-form-item label="网站图片" prop="sitePath">
          <site-picture v-if="open" :site-path="baseUrl + form.sitePath" @uploadPicture="uploadPicture"/>
          <span class="site-form-path-tip">提示：点击图片可进行裁剪和上传</span>
          <el-upload
              class="avatar-uploader"
              :headers="headers"
              :action="uploadSiteImgUrl"
              accept=".jpg,.png,.ico,.gif,.jpeg,.tiff"
              :show-file-list="false"
              :on-success="handleSiteImgSuccess"
              :on-error="handleSiteImgError"
              :before-upload="beforeAvatarUpload"
              name="pictureFile"
              size="mini">
            <el-button type="primary" size="mini">上传</el-button>
            <el-button type="success" size="mini" @click.stop="handleDefaultImg">默认</el-button>
          </el-upload>
        </el-form-item>

        <el-form-item label="状态">
          <el-radio-group v-model="form.status">
            <el-radio
              v-for="dict in statusOptions"
              :key="dict.dictValue"
              :label="parseInt(dict.dictValue)"
            >{{dict.dictLabel}}</el-radio>
          </el-radio-group>
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
import { listSite, getSite, delSite, addSite, updateSite,getSiteMaxOrderNum,collectSiteIcon } from "@/api/nav/site";
import { treeSelect } from "@/api/nav/menu";
import { getToken } from "@/utils/auth";

import Treeselect from "@riophae/vue-treeselect";
import "@riophae/vue-treeselect/dist/vue-treeselect.css";
import SiteCard from "@/components/SiteCard/SiteCard";
import SitePicture from "../components/SitePicture";

export default {
  name: "NavSite",
  components: {Treeselect,SiteCard,SitePicture},
  data() {
    return {
      // 遮罩层
      loading: true,
      // 总条数
      total: 0,
      // 导航网站信息表格数据
      siteList: [],
      // 弹出层标题
      title: "",
      siteId: undefined,
      // 是否显示弹出层
      open: false,
      // 显示搜索条件
      showSearch: true,
      // 状态，0 正常，1 删除字典
      statusOptions: [],
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 12,
        menuId: undefined,
        siteName: undefined,
        createTime: undefined,
        status: undefined
      },
      defaultSiteImg: '/profile/site/system/logo.jpg',
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        menuId: [
          { required: true, message: "请选择所属菜单", trigger: "blur" }
        ],
        siteName: [
          { required: true, message: "名称不能为空", trigger: "blur" }
        ],
        siteUrl: [
          { required: true, message: "网站地址不能为空", trigger: "blur" }
        ],
      },
      // 菜单树选项
      menuOptions: [],
      // 图片基本地址
      baseUrl: process.env.VUE_APP_BASE_FILE,
      // 上传网站图片地址
      uploadSiteImgUrl: process.env.VUE_APP_BASE_API + "/nav/site/uploadSiteImg",
      // 设置上传的请求头部
      headers: { Authorization: "Bearer " + getToken() },
      siteCollectLoading: false
    };
  },
  computed: {
    showCount() {
      return this.$store.state.settings.showCount
    },
  },
  created() {
    this.getList();
    this.getDicts("nav_site_status").then(response => {
      this.statusOptions = response.data;
    });
    this.getTreeSelect();
  },
  methods: {
    /** 查询导航网站信息列表 */
    getList() {
      this.loading = true;
      listSite(this.queryParams).then(response => {
        this.siteList = response.rows;
        this.total = response.total;
        this.loading = false;
      });
    },
    // 状态，0 正常，1 删除字典翻译
    statusFormat(row, column) {
      return this.selectDictLabel(this.statusOptions, row.status);
    },
    // 取消按钮
    cancel() {
      this.open = false;
      this.reset();
    },
    // 表单重置
    reset() {
      this.form = {
        siteId: undefined,
        menuId: undefined,
        siteName: undefined,
        sitePath: undefined,
        siteDescription: undefined,
        siteUrl: undefined,
        createTime: undefined,
        updateTime: undefined,
        createBy: undefined,
        updateBy: undefined,
        status: "0"
      };
      this.resetForm("form");
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
    /** 新增按钮操作 */
    handleAdd() {
      this.reset();
      this.open = true;
      this.title = "添加";
      this.getTreeSelect();
      this.form.status = 0;
      this.form.sitePath = this.defaultSiteImg;
      this.form.menuId = this.queryParams.menuId;
      this.form.orderNum = 1;
      // 设置网站菜单下最大的排序
      this.setSiteMaxOrderNum()
    },
    /** 修改按钮操作 */
    handleUpdate(site) {
      this.reset();
      const siteId = site.siteId
      getSite(siteId).then(response => {
        this.form = response.data;
        this.open = true;
        this.title = "修改";
      });
    },
    /** 提交按钮 */
    submitForm: function() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.siteId != undefined) {
            updateSite(this.form).then(response => {
              if (response.code === 200) {
                this.msgSuccess("修改成功");
                this.open = false;
                this.getList();
              }
            });
          } else {
            addSite(this.form).then(response => {
              if (response.code === 200) {
                this.msgSuccess("新增成功");
                this.open = false;
                this.getList();
              }
            });
          }
        }
      });
    },
    /** 删除按钮操作 */
    handleDelete(site) {
      const siteIds = site.siteId;
      this.$confirm('是否确认删除网站【' + site.siteName + '】的数据?', "警告", {
          confirmButtonText: "确定",
          cancelButtonText: "取消",
          type: "warning"
        }).then(function() {
          return delSite(siteIds);
        }).then(() => {
          this.getList();
          this.msgSuccess("删除成功");
        }).catch(function() {});
    },
    /** 转换菜单数据结构 */
    normalizer(node) {
      if (node.children && !node.children.length) {
        delete node.children;
      }
      return {
        id: node.menuId,
        label: node.menuName,
        children: node.children
      };
    },
    /** 查询菜单下拉树结构 */
    getTreeSelect() {
      treeSelect().then(response => {
        this.menuOptions = this.handleTree(response.data, "menuId");
      });
    },

    handleSiteImgSuccess(res) {
      if (res.code == 200) {
        this.form.sitePath = res.data;

      } else {
        this.msgError("上传网站图片失败！");
      }
    },
    handleSiteImgError(err, file, fileList) {
     this.msgError(err);
    },
    beforeAvatarUpload(file) {
      const imgType = ['image/jpeg','image/x-icon'];
      const isJPG = imgType.map(function (type) {
        return file.type === type;
      });
      const isLt2M = file.size / 1024 / 1024 < 2;

      if (!isJPG) {
        this.msgError('上传图片只能是 JPG、PNG 格式!');
      }
      if (!isLt2M) {
        this.msgError('上传图片大小不能超过 2MB!');
      }
      return isJPG && isLt2M;
    },
    //修改图片后的回传事件
    uploadPicture(sitePath) {
      this.form.sitePath = sitePath;
    },
    // 设置网站菜单下最大的排序
    setSiteMaxOrderNum() {
      if (this.form.menuId != undefined && this.form.menuId != '') {
        // 获取网站菜单下最大的排序
        getSiteMaxOrderNum(this.form.menuId).then(response => {
          if (response.code == 200 ) {
            this.form.orderNum = response.data != undefined ? response.data + 1 : 1
            this.$forceUpdate()
          }
        })
      }
    },
    // 设置默认图片
    handleDefaultImg() {
      this.form.sitePath = this.defaultSiteImg;
    },

    // 新增或修改选择菜单时，设置排序
    handleAddEditSelectMenu() {
      if (this.form.siteId == undefined) {
        this.setSiteMaxOrderNum();
      }
    },
    handleSiteCardMouseEnter(siteId) {
      this.siteId = siteId;
    },
    handleSiteCardMouseLeave() {
      this.siteId = undefined;
    },
    // 网站图标采集事件
    handleCollectSiteIcon() {
      if (this.form.siteUrl == undefined || this.form.siteUrl == '') {
        this.msgError('输入网站地址后才能才能采集图片哦！');
        return;
      }
      this.siteCollectLoading = true;
      collectSiteIcon(this.form.siteUrl).then(response => {
        if (response.code == 200) {
          this.form.sitePath = response.data;
          this.msgSuccess('采集网站图片成功！');
          this.$forceUpdate();
        }
        this.siteCollectLoading = false;
      }).catch(() => {
        this.siteCollectLoading = false;
      })
    }
  }
};
</script>

<style scoped>
  .avatar-uploader .el-upload {
    border: 1px dashed #e51111;
    border-radius: 6px;
    cursor: pointer;
    position: relative;
    overflow: hidden;
  }
  .avatar-uploader .el-upload:hover {
    border-color: #409EFF;
  }
  .avatar-uploader-icon {
    font-size: 28px;
    color: #8c939d;
    width: 178px;
    height: 178px;
    line-height: 178px;
    text-align: center;
  }
  .avatar {
    width: 178px;
    height: 178px;
    display: block;
  }

  .belong-menu {
    display: -webkit-box;
    -webkit-box-orient: vertical;
    -webkit-line-clamp: 1;
    overflow: hidden;
    font-size: 13px;
    margin-bottom: 5px;
    color: #979898;
  }
  .card-footer-icon {
    color: #979898;
    font-size: 13px;
    margin: 0 15px 5px 0;
  }

  .system-site-card {
    opacity: 0.6;
  }


  .site-card-close {
    position: absolute;
    height: 30px;
    width: 30px;
    border-radius: 15px;
    line-height: 30px;
    text-align: center;
    font-size: 18px;
    color: white;
    background-color: #F33333;
    top: -5px;
    right: -5px;
    cursor: pointer;
    z-index: 1;
  }
  .site-card-edit {
    position: absolute;
    height: 30px;
    width: 30px;
    border-radius: 15px;
    line-height: 30px;
    text-align: center;
    color: white;
    background-color: #2CAB4E;
    font-size: 22px;
    top: 35%;
    left: 45%;
    z-index: 1;
    cursor: pointer;
  }
  .site-form-path-tip {
    color: #515a6e;
    font-size: 12px;
  }
</style>
