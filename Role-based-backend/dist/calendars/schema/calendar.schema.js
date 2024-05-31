"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.CalendarsSchema = exports.Calendars = void 0;
const mongoose_1 = require("@nestjs/mongoose");
const posts_schema_1 = require("../../posts/schemas/posts.schema");
const user_schema_1 = require("../../user/schemas/user.schema");
const mongoose_2 = require("mongoose");
let Calendars = class Calendars {
};
exports.Calendars = Calendars;
__decorate([
    (0, mongoose_1.Prop)({ type: mongoose_2.default.Schema.Types.ObjectId, ref: 'User' }),
    __metadata("design:type", user_schema_1.User)
], Calendars.prototype, "user", void 0);
__decorate([
    (0, mongoose_1.Prop)({ type: mongoose_2.default.Schema.Types.ObjectId, ref: 'Posts' }),
    __metadata("design:type", posts_schema_1.Posts)
], Calendars.prototype, "post", void 0);
__decorate([
    (0, mongoose_1.Prop)({ required: true }),
    __metadata("design:type", Date)
], Calendars.prototype, "date", void 0);
exports.Calendars = Calendars = __decorate([
    (0, mongoose_1.Schema)({
        timestamps: true
    })
], Calendars);
exports.CalendarsSchema = mongoose_1.SchemaFactory.createForClass(Calendars);
//# sourceMappingURL=calendar.schema.js.map