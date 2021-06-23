<template>
  <div>
    <div>
      <i class="el-icon-s-comment" style="font-size: 20px;"> {{total}} 条评论</i>
    </div>

    <!-- 发布评论框 -->
    <div style="margin-top: 20px;margin-bottom: 20px" id="commentContent">
      <el-form style="margin-top: 20px" :model="form" ref="form" :rules="rules">
        <el-form-item prop="commentContent">
          <el-input type="textarea" :rows="4" placeholder="请输入评论内容" v-model="form.commentContent"></el-input>
        </el-form-item>
        <el-row :gutter="24" v-if="!isLogin">
          <el-col :xs="24" :sm="12">
            <el-form-item prop="nickName">
              <el-input v-model="form.nickName" placeholder="昵称"><i slot="prefix" class="el-icon-user-solid"></i></el-input>
            </el-form-item>
          </el-col>
          <el-col :xs="24" :sm="12">
            <el-form-item prop="email">
              <el-input v-model="form.email" placeholder="邮箱"><i slot="prefix" class="el-icon-message"></i></el-input>
            </el-form-item>
          </el-col>
        </el-row>
      </el-form>
      <div class="publish-btn-div-parent" :style="{'margin-top' : isLogin ? '20px' : '0px'}">
        <div class="publish-btn-div">
          <el-button type="danger" size="small" v-if="form.parentId" @click="handleThinkAbout">再想想</el-button>
          <el-button type="primary" size="small" @click="handlePublishComment" :disabled="submitLoading">
            <span v-if="submitLoading">发表中</span>
            <span v-else>发表评论</span>
          </el-button>
        </div>
      </div>
    </div>

    <!-- 评论列表 -->
    <div  v-if="total > 0">
    <el-container v-for="comment in commentList" :key="comment.commentId" :class="comment.parentId > 0 ? 'parent-comment' : ''">
      <el-aside class="aside">
        <el-image class="aside-image"  :src="baseUrl + comment.avatar" lazy>
          <div slot="error" class="image-slot">
            <el-image class="aside-image" :src="require('@/assets/images/profile.jpg')"/>
          </div>
        </el-image>
      </el-aside>
      <el-main class="main">
        <div class="nickName">
          <el-tag type="primary" size="small" effect="dark" class="sticky" v-if="comment.sticky == 1">置顶</el-tag>
          <span>{{comment.nickName}}</span>
          <el-tag v-if="comment.webMaster" class="user-web-master" type="danger" size="mini" effect="plain">站长</el-tag>
        </div>
        <div v-html="comment.commentContent" class="comment-content"></div>
        <div class="comment-time-div">
          <span class="comment-time">{{parseDate(comment.commentTime,'yyyy年MM月dd日 hh:mm:ss')}}</span>
          <span class="reply" @click="handleReply(comment.commentId)">回复</span>
        </div>
        <el-divider/>
      </el-main>
    </el-container>
    </div>
    <div v-else class="no-comment">暂无评论，赶紧去评论抢占沙发吧！</div>

  </div>
</template>

<script>
  import { addComment } from '@/api/nav/comment'
  import { getToken } from '@/utils/auth'
  import { getCommentList } from '@/api/front/frontNav'

  export default {
    name: 'AboutComment',
    data() {
      return {
        commentList: [],
        total: 0,
        submitLoading: false,
        // 图片基本地址
        baseUrl: process.env.VUE_APP_BASE_FILE,
        form: {
          commentContent: '',
          parentId: undefined,
          nickName: '',
          email: ''
        },
        rules: {
          email: {
            type: 'email', message: '请输入正确的邮箱地址', trigger: ['blur', 'change']
          }
        }
      }
    },
    computed: {
      isLogin() {
        return getToken();
      },
    },
    created() {
      this.getCommentList();
    },
    methods: {
      /** 获取评论 */
      getCommentList() {
        getCommentList().then(response => {
          this.total = response.rows;
          let commentList = response.data;
          commentList.forEach(comment => {
            this.commentList.push(comment);
            this.recursiveComment(comment.children);
          })
        })
      },
      /** 递归添加评论 */
      recursiveComment(commentList) {
        commentList.forEach(comment => {
          this.commentList.push(comment);
          if (comment.children != undefined && comment.children.length > 0) {
            this.recursiveComment(comment.children);
          }
        })
      },
      handleReply(commentId) {
        let e = document.querySelector('#commentContent');
        let top = e.offsetTop - 60;
        this.scrollTop(top, 80);
        this.form.parentId = commentId;
      },
      /** 再想想点击事件 */
      handleThinkAbout() {
        this.form.parentId = undefined;
      },
      /** 发表评论事件 */
      handlePublishComment() {
        if (this.form.commentContent === '') {
          this.msgError('请输入评论内容！');
          return;
        }
        if (!this.isLogin) {
          if (this.form.nickName === '') {
            this.msgError('昵称不能为空！');
            return ;
          }
          if (this.form.email === '') {
            this.msgError('邮箱不能为空！');
            return ;
          }
          // 验证信息
          this.$refs['form'].validate((valid) => {
            if (!valid) {
              return ;
            }
          });
        }
        // 开始提交
        this.submitLoading = true;
        addComment(this.form).then(response => {
          if (response.code == 200) {
            this.msgSuccess('提交评论成功！');
            this.$refs['form'].resetFields();
            this.getCommentList();
          }
          this.submitLoading = false;
        }).catch(error => {
          this.submitLoading = false;
        })
      },
    }
  }
</script>

<style scoped lang="scss">
  /* 清除高度坍塌 */
  .publish-btn-div-parent:after {
      content: "";
      display: block;
      clear: both;
      width: 0;
      height: 0;
  }
  .publish-btn-div-parent {
    .publish-btn-div {
      float: right;
    }
  }

  .parent-comment {
    margin-left: 50px;
  }
  .aside {
    background-color: white !important;
    width: 50px !important;
    padding: 0 !important;
    text-align: center !important;;
    .aside-image {
      border-radius: 50%;
      width: 50px;
      height: 50px;
    }
  }
  .main {
    padding: 0 !important;
    margin-left: 20px !important;
    .nickName {
      font-size: 18px;
      font-weight: bold;
      .user-web-master {
        font-size: 13px;
        margin-left: 5px;
      }
      .sticky {
        margin-right: 5px;
      }
    }
    .comment-content {
      margin-top: 10px;
    }
    .comment-time-div {
      font-size: 14px;
      margin-top: 10px;
      .comment-time {
        color: #5a5e66;
      }
      .reply {
        float: right;
        cursor: pointer;
      }
    }
  }

  .no-comment {
    text-align: center;
    font-size: 18px;
  }
</style>
