<template>
  <div
    class="login-container"
    :style="{ backgroundImage: 'url(' + backgroundImage + ')' }"
  >
    <el-form
      class="login-form"
      :model="loginForm"
      :rules="loginRules"
      ref="loginRef"
    >
      <h3 class="title">{{ title }}</h3>
      <el-form-item prop="username">
        <el-input
          v-model="loginForm.username"
          type="text"
          auto-complete="off"
          placeholder="用户名"
        >
          <template #prefix>
            <svg-icon icon-name="user" class="el-input__icon input-icon" />
          </template>
        </el-input>
      </el-form-item>
      <el-tooltip
        v-model:visible="capsTooltip"
        content="大写已开启"
        placement="right"
      >
        <el-form-item prop="password">
          <el-input
            v-model="loginForm.password"
            :type="passwordType"
            auto-complete="off"
            placeholder="密码"
            @keyup="checkCapslock"
            @blur="capsTooltip = false"
            @keyup.enter="handleLogin"
          >
            <template #prefix>
              <svg-icon
                icon-name="password"
                class="el-input__icon input-icon"
              />
            </template>
          </el-input>
          <span class="show-password" @click="handleShowPassword">
            <svg-icon
              :icon-name="passwordType === 'password' ? 'eye' : 'eye-open'"
            />
          </span>
        </el-form-item>
      </el-tooltip>
      <el-form-item prop="code">
        <el-input
          v-model="loginForm.code"
          auto-complete="off"
          placeholder="验证码"
          class="code-input"
          @keyup.enter="handleLogin"
        >
          <template #prefix>
            <svg-icon icon-name="validCode" class="el-input__icon input-icon" />
          </template>
        </el-input>
        <div class="login-code" v-loading="loadingCodeImage">
          <img :src="codeImageUrl" @click="getCode" class="login-code-img" />
        </div>
      </el-form-item>
      <el-form-item style="width: 100%">
        <el-button
          :loading="loading"
          size="medium"
          type="primary"
          class="login-button"
          @click.prevent="handleLogin"
        >
          <span v-if="!loading">登 录</span>
          <span v-else>登 录 中...</span>
        </el-button>
      </el-form-item>
    </el-form>
  </div>
</template>

<script setup>
import { ref, getCurrentInstance } from 'vue'
import { useStore } from 'vuex'
import { useRouter } from 'vue-router'

import { title } from '@/config'
import LoginBackground from '@/assets/images/login-background.jpg'

import { getCaptchaImage } from '@/api/auth/login'
import { getBingImage } from '@/api/common/bing'

const { proxy } = getCurrentInstance()
const store = useStore()
const router = useRouter()

const loginForm = ref({
  username: '',
  password: '',
  code: '',
  uuid: ''
})

// 大写提示
const capsTooltip = ref(false)
/**
 * 检测是否为大写
 */
function checkCapslock(e) {
  const { key } = e
  capsTooltip.value = key && key.length === 1 && key >= 'A' && key <= 'Z'
}

// 密码类型
const passwordType = ref('password')
/**
 * 是否显示密码
 */
function handleShowPassword() {
  passwordType.value = passwordType.value === 'password' ? 'text' : 'password'
}

// 验证码路径
const codeImageUrl = ref('')
// 验证码路径
const loadingCodeImage = ref(true)
// 获取验证码
async function getCode() {
  loadingCodeImage.value = true
  try {
    const {
      data: { uuid, image }
    } = await getCaptchaImage()
    loginForm.value.uuid = uuid
    codeImageUrl.value = image
  } finally {
    loadingCodeImage.value = false
  }
}

// 验证规则
const loginRules = ref({
  username: [{ required: true, trigger: 'blur', message: '用户名不能为空' }],
  password: [
    { required: true, trigger: 'blur', validator: validatePassword() }
  ],
  code: [{ required: true, trigger: 'blur', message: '验证码不能为空' }]
})
// 密码验证规则
function validatePassword() {
  return (rule, value, callback) => {
    if (!value) {
      callback(new Error('密码不能为空'))
    } else if (value.length < 6) {
      callback(new Error('密码不能少于6位'))
    } else {
      callback()
    }
  }
}

// 登录加载
const loading = ref(false)
// 跳转地址
const redirect = ref(router.currentRoute.value.query.redirect)
// 登录
function handleLogin() {
  proxy.$refs.loginRef.validate((valid) => {
    if (!valid) {
      return
    }
    loading.value = true
    // 调用action的登录方法
    store
      .dispatch('user/login', loginForm.value)
      .then(() => {
        router.push(redirect.value || '/index')
      })
      .catch(() => {
        // 重新获取验证码
        getCode()
      })
      .finally(() => {
        loading.value = false
      })
  })
}

// 背景图片
const backgroundImage = ref(LoginBackground)
// 获取背景图片
async function getBackgroundImage() {
  const {
    data: { imageUrl }
  } = await getBingImage()
  backgroundImage.value = imageUrl
}

getCode()
getBackgroundImage()
</script>

<style lang="scss" scoped>
.login-container {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100%;
  background-size: cover;
  background-color: #2d3a4b;
  background-image: url('~@/assets/images/login-background.jpg');

  .title {
    margin: 0px auto 30px auto;
    text-align: center;
    color: #707070;
  }

  .login-form {
    border-radius: 6px;
    background: #ffffff;
    width: 400px;
    padding: 25px 25px 5px 25px;
    .el-input {
      height: 38px;
      input {
        height: 38px;
      }
      .input-icon {
        height: 39px;
        width: 14px;
        margin-left: 2px;
      }
    }
    .show-password {
      height: 39px;
      width: 14px;
      position: absolute;
      right: 10px;
      font-size: 16px;
      color: #889aa4;
      cursor: pointer;
      user-select: none;
    }
    .code-input {
      width: 63%;
    }
    .login-code {
      width: 37%;
      height: 38px;
      float: right;
      text-align: center;
      .login-code-img {
        cursor: pointer;
        vertical-align: middle;
      }
    }
    .login-button {
      width: 100%;
    }
  }
}
</style>
