const mongoose = require("mongoose"); //kết nối DBDB
const validator = require("validator"); //Thư viện kiểm tra ràng buộc
const { ObjectId } = mongoose.Schema.Types; // lấy ID của một đối tượng trong bảng gán cho ObjectId
const CompanySchema = new mongoose.Schema({
  //định nghĩa table temp chưa lưu vào DB (gom dữ liệu thành 1 bảng)
  name: {
    type: String,
    required: true, // == Not Null (1 chiều từ User --> DB)
  },
  phone: {
    type: String,
    required: true,
    unique: true, // == kiểm tra không trùng = true, trùng = false
    /*kiểm tra đúng kiểu SDT*/
    validate: {
      validator: function (number) {
        return /(03|07|08|09|01[2|6|8|9])+([0-9]{8})\b/.test(number);
      },
      message: (Error) => "Không phải số điện thoại !",
    },
  },
  email: {
    type: String,
    required: true,
  },
  web: {
    type: String,
    required: true,
  },

  avatar: {
    type: String,
    default: "",
  },

  tokens: [{ token: { type: String, required: true } }],
});

const Company = mongoose.model("Company", CompanySchema); //đặt tên cho bản tạm thời

module.exports = Company; // cho phép các file khác có thể sử dụng file này (public file này lên)
