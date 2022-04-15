const validateFns = {
  required(key, val) {
    if (!val) {
      return `${key}(은)는 필수항목 입니다.`;
    }
  },
  onlyNumber(key, val) {
    if (!/^[0-9]*$/.test(val)) {
      return `${key}(은)는 숫자만 가능합니다.`;
    }
  },
  onlyAlphabet(key, val) {
    if (!/^[a-zA-Z]*$/.test(val)) {
      return `${key}(은)는 영문만 가능합니다.`;
    }
  },
  hangul(key, val) {
    if (!/^[가-힣]*$/.test(val)) {
      return `${key}(은)는 한글만 가능합니다.`;
    }
  },
  alphaNum(key, val) {
    if (!/^[a-zA-Z0-9]*$/.test(val)) {
      return `${key}(은)는 영문 또는 숫자만 가능합니다.`;
    }
  },
  passwd1(key, val) {
    if (!/^[A-Za-z0-9]{6,12}$/.test(val)) {
      return `${key}(은)는 숫자, 문자 포함 6~12자리 이내만 가능합니다.`;
    }
  },
  passwd2(key, val) {
    if (
      !/^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/.test(val)
    ) {
      return `${key}(은)는 숫자, 문자, 특수문자 포함 8~15자리 이내만 가능합니다.`;
    }
  },
  email(key, val) {
    if (
      !/^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/.test(
        val
      )
    ) {
      return `${key}(은)는 이메일 형식이 아닙니다.`;
    }
  },
  cellphone1(key, val) {
    if (!/^[0-9]{10,11}$/.test(val)) {
      return `${key}(은)는 휴대폰 번호 형식이 아닙니다.`;
    }
  },
  cellphone2(key, val) {
    if (!/^\\d{3}-\\d{3,4}-\\d{4}$/.test(val)) {
      return `${key}(은)는 휴대폰 번호 형식이 아닙니다.`;
    }
  },
  tellno(key, val) {
    if (!/^\\d{2,3}-\\d{3,4}-\\d{4}$/.test(val)) {
      return `${key}(은)는 전화번호 형식이 아닙니다.`;
    }
  },
  juminNo(key, val) {
    if (!/\d{6} - [1-4]\d{6}/.test(val)) {
      return `${key}(은)는 주민번호 형식이 아닙니다.`;
    }
  },
  yyyymmdd(key, val) {
    if (!/^[0-9]{8}$/.test(val)) {
      return `${key}(은)는 yyyymmdd형식입니다.`;
    }
  },
  min3(key, val) {
    if (!val || val.length < 3) {
      return `${key}(은)는 최소 3자 이상이어야 합니다.`;
    }
  },
  min2(key, val) {
    if (!val || val.length < 2) {
      return `${key}(은)는 최소 2자 이상이어야 합니다.`;
    }
  },
};

const validator = {
  errors: {},
  validates: new Map(),
  setup(key, expression) {
    const validates = expression.replace(/'/g, "").split("|");
    this.validates.set(key, validates);
  },
  validate(key, value) {
    const validates = this.validates.get(key);
    const errors = [];
    validates.map((v) => {
      let err = validateFns[v](key, value);
      if (err) errors.push(err);
    });
    return errors;
  },
};

const directives = {
  validate: {
    bind(el, binding, vnode) {
      validator.setup(el.name, binding.expression, vnode.context);
    },
    updat(el, binding, vnode) {
      const key = el.name;
      const errors = validator.validate(key, el.value);
      const s = JSON.stringify;

      if (s(errors) === s(vnode.context.errorBag[key])) return;
      if (errors.length) {
        vnode.context.$set(vnode.context.errorBag, key, errors);
      } else {
        vnode.context.$delete(vnode.context.errorBag, key);
      }
    },
  },
};

export { validator, directives };
