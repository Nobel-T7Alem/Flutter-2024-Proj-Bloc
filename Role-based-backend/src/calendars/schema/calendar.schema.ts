import { Prop, Schema, SchemaFactory } from "@nestjs/mongoose";
import { Document } from 'mongoose';
import { Posts } from "src/posts/schemas/posts.schema";
import { User } from "src/user/schemas/user.schema";
import mongoose from "mongoose";

@Schema({
    timestamps: true
})
export class Calendars {
    @Prop({ type: mongoose.Schema.Types.ObjectId, ref: 'User' })
    user: User;
    @Prop({ type: mongoose.Schema.Types.ObjectId, ref: 'Posts'}) 
    post: Posts;

    @Prop({ required: true })
    date: Date;
}

export const CalendarsSchema = SchemaFactory.createForClass(Calendars);
