export default {
  namespaced: true,
  state: {
    users: [],
    user: {
      id: "dolodry2",
      passwd: "1234",
      userKindCd: "0004",
      name: "이순신",
      birthday: "19770505",
      cellPhoneNo: "010-3333-4444",
      useYn: "Y",
      grade_history: [],
      addrs: [
        {
          id: "doldory",
          seqNo: 0,
          addr: "인천관역시 남동구 만수서로 55",
          addrDetail: "향촌 휴먼시아 124동 502호",
          useYn: "Y",
        },
      ],
    },
  },
  getters: {
    getUser: (state) => {
      return state.user;
    },
    getUserByIdx(state, idx) {
      return state.users[idx];
    },
    getUserIdentify(state) {
      let u = state.user;
      return u.name + "[" + u.id + "]";
    },
    getUserIdentifyByIdx(state, idx) {
      let u = state.users[idx];
      return u.name + "[" + u.id + "]";
    },
  },
  mutations: {
    setUsers(state, users) {
      state.users = users;
    },
    setUserId(state, value) {
      if (value.target && value.target.value) {
        state.user.id = value.target.value;
        return;
      }
      state.user.id = value;
    },
    setUserPasswd(state, value) {
      if (value.target && value.target.value) {
        state.user.passwd = value.target.value;
        return;
      }
      state.user.passwd = value;
    },
    addUser(state, user) {
      state.users.push(user);
    },
  },
  actions: {
    fetchUser({ commit }, params) {
      window
        .axios({
          url: params.url,
          data: params.data,
        })
        .then((res) => {
          console.log(res);
          if (params.postFnc) params.postFnc(res);
        })
        .catch((error) => {
          if (error.response) {
            console.log(error.response.data);
            console.log(error.response.status);
            console.log(error.response.headers);
          } else {
            console.log("Error", error.message);
          }
        });
    },
    addUser({ commit, state }, params) {
      // console.log(JSON.stringify(state.user));
      window
        .axios({
          method: "POST",
          url: "/api/user/joinUser.do",
          data: state.user,
        })
        .then((res) => {
          console.log(res);
        })
        .catch((error) => {
          console.error(error);
        });
    },
  },
};
