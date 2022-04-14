const validateFns = {
  required(key, val) {
    if (!val) {
      return `${key}(은)는 필수항목 입니다.`;
    }
  },
  minLen3(key, val) {
    if (!val || val.length < 3) {
      return `${key}(은)는 최소 3자 이상이어야 합니다.`;
    }
  },
};

const validator = {
  // init() {
  //     this.errors = {}
  //     this.validates = new Map()
  //     return this
  // },
  errors: {},
  validates: new Map(),
  setup(key, expression) {
    const validates = expression.replace(/'/g, "").split("|");
    this.validates.set(key, validates);
  },
  validate(key, value) {
    const validates = this.validates.get(key);
    const errors = validates
      .map((v) => validateFns[v](key, value))
      .filter((v) => !!v);
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
