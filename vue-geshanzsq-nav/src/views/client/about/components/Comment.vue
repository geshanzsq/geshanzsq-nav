<template>
  <div class="comment" v-loading="loading">
    <div class="total">
      <el-icon class="message-icon"><Comment /></el-icon>
      <span>{{ dataList.length }} 条评论</span>
    </div>

    <!-- 发布评论框 -->
    <div id="publish-comment">
      <send-comment
        :parent-id="parentId"
        @cancel="handleCancel"
        @success="getData"
      />
    </div>

    <div v-if="dataList.length > 0" class="main-comment">
      <div
        v-for="comment in dataList"
        :key="comment.id"
        :class="comment.parentId > 0 ? 'parent-comment' : ''"
        :id="'comment-' + comment.id"
      >
        <el-container>
          <el-aside class="aside">
            <el-image
              class="avatar"
              lazy
              :src="
                comment.avatar
                  ? getPictureShowUrl(comment.avatar)
                  : userDefaultAvatar
              "
            >
              <template #error>
                <div class="image-slot">
                  <el-image class="avatar" lazy :src="userDefaultAvatar">
                  </el-image>
                </div>
              </template>
            </el-image>
          </el-aside>

          <el-main class="main">
            <div class="nick-name">
              <el-tag
                type="primary"
                effect="dark"
                class="sticky"
                v-if="comment.hasSticky == 1"
                >置顶</el-tag
              >
              <span>{{ comment.nickName }}</span>
              <el-tag
                type="error"
                class="user-web-master"
                v-if="comment.webMaster"
              >
                <span>站长</span>
              </el-tag>
              <el-tag
                type="error"
                class="user-pro"
                v-if="!comment.webMaster && comment.createUserId"
              >
                <span>PRO</span>
              </el-tag>
            </div>
            <div
              v-if="comment.parentId > 0"
              class="parent-content"
              @click="handlePosition('comment-' + comment.parent.id)"
            >
              回复：
              <span v-html="comment.parent.commentContent"></span>
            </div>
            <div
              v-html="comment.commentContent"
              v-highlight
              class="content"
            ></div>
            <div class="comment-time">
              <span class="time">{{ parseTime(comment.gmtCreate) }}</span>
              <span class="reply" @click="handleReply(comment.id)">回复</span>
            </div>
            <send
              v-if="comment.id === parentId"
              :article-id="articleId"
              :parent-id="parentId"
              @cancel="handleCancelPublish"
              @success="handleSuccessPublish"
            />
            <el-divider />
          </el-main>
        </el-container>
      </div>
    </div>
    <el-empty v-else description="还没有评论，赶紧去评论抢占沙发吧！" />
  </div>
</template>
<script setup>
import { ref } from 'vue'
import { getTree } from '@/api/client/comment'
import { scrollTo } from '@/utils/scroll-to'

import SendComment from './SendComment'

import userDefaultAvatar from '@/assets/images/profile.jpg'

const loading = ref(true)
const dataList = ref([])
const parentId = ref(undefined)

async function getData() {
  loading.value = true
  const { data } = await getTree()
  dataList.value = []
  data.forEach((comment) => {
    dataList.value.push(comment)
    recursiveComment(comment, comment.children)
  })
  loading.value = false
}

/**
 * 递归添加评论
 */
function recursiveComment(parentData, data) {
  if (!(data instanceof Array)) {
    return
  }
  data.forEach((comment) => {
    comment.parent = parentData
    dataList.value.push(comment)
    if (comment.children instanceof Array && comment.children.length > 0) {
      recursiveComment(comment, comment.children)
    }
  })
}
/**
 * 描点定位到上级评论
 */
function handlePosition(parentId) {
  const e = document.querySelector('#' + parentId)
  scrollTo(e.offsetTop - 50, 500)
}

/**
 * 点击回复事件
 */
function handleReply(id) {
  parentId.value = id
  const e = document.querySelector('#publish-comment')
  scrollTo(e.offsetTop - 20, 500)
}

/**
 * 取消发布按钮
 */
function handleCancel() {
  parentId.value = 0
}

getData()
</script>
<style scoped lang="scss">
.comment {
  margin-top: 30px;
  .total {
    font-size: 20px;
    display: flex;
    align-items: center;
    .message-icon {
      font-size: 22px;
    }
  }

  #publish-comment {
    margin-top: 20px;
    margin-bottom: 20px;
  }

  .main-comment {
    .parent-comment {
      margin-left: 50px;
    }

    .aside {
      background-color: white !important;
      width: 50px !important;
      height: 50px !important;
      padding: 0 !important;
      overflow: hidden;
      text-align: center !important;
      border-radius: 50%;

      .avatar {
        border-radius: 50%;
        width: 50px;
        height: 50px;
      }
    }

    .main {
      padding: 0 !important;
      margin-left: 20px !important;
      .nick-name {
        font-size: 18px;
        font-weight: bold;
        .sticky {
          margin-right: 5px;
        }
        .user-web-master {
          font-size: 13px;
          margin-left: 5px;
        }
        .user-pro {
          cursor: pointer;
          margin-left: 5px;
          color: white;
          background: linear-gradient(
            to right,
            #409eff,
            rgba(172, 81, 252, 0.96),
            #e6a23c
          );
        }
        .user-pro:hover {
          background: linear-gradient(
            to right,
            rgba(172, 81, 252, 0.96),
            #e6a23c,
            #409eff
          );
        }
      }
      .content {
        margin-top: 10px;
      }

      /*设置图片，以防过大*/
      .content >>> img {
        max-width: 100%;
        height: auto;
        cursor: pointer;
      }

      .parent-content {
        margin-top: 10px;
        color: var(--el-text-color-secondary);
        font-size: var(--el-font-size-small);
        display: -webkit-box;
        -webkit-box-orient: vertical;
        -webkit-line-clamp: 2;
        overflow: hidden;
        cursor: pointer;
      }

      .comment-time {
        font-size: 14px;
        margin-top: 10px;
        .time {
          color: var(--el-text-color-secondary);
          font-size: var(--el-font-size-small);
        }
        .reply {
          float: right;
          cursor: pointer;
        }
      }
    }
  }
}
</style>
