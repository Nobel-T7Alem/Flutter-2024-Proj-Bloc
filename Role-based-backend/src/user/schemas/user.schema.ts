import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';

export enum UserRole {
  Admin = 'admin',
  User = 'user',
  Agency = 'agency'
}

@Schema({
  timestamps: true,
})
export class User {
  @Prop()
  name: string;

  @Prop({ unique: [true, 'Duplicate username entered'] })
  username: string;

  @Prop({ unique: [true, 'Duplicate email entered'] })
  email: string;

  @Prop()
  password: string;

  @Prop()
  role: UserRole;
}

export const UserSchema = SchemaFactory.createForClass(User);