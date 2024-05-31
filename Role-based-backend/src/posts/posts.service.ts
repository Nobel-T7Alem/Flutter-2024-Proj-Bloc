import { BadGatewayException, BadRequestException, Injectable, NotFoundException } from '@nestjs/common';
import { Posts } from './schemas/posts.schema';
import mongoose, { Model } from 'mongoose'
import { InjectModel } from '@nestjs/mongoose';
import { User } from 'src/user/schemas/user.schema';
import { extname, join } from 'path';
import { v4 as uuidv4 } from 'uuid';
import * as fs from 'fs';


export interface MulterFile {
  fieldname: string;
  originalname: string;
  encoding: string;
  mimetype: string;
  size: number;
  destination: string;
  filename: string;
  path: string;
  buffer: Buffer;
}

@Injectable()
export class PostsService {
  constructor(
    @InjectModel('posts') private readonly postsModel: Model<Posts>,
  ) { }

  //creating a posts
  async createPosts(posts: Posts, user: User): Promise<Posts> {
    const newPosts = await new this.postsModel(posts)
    return newPosts.save()
  }


  //reading posts collection 
  async readPosts() {
    return this.postsModel.find({})
      .then((posts) => { return posts })
      .catch((err) => console.log(err))
  }

  //All posts
  async findAll(query: any): Promise<Posts[]> {
    const posts = await this.postsModel.find();


    return posts;
  }

  //find posts by id
  async findById(id: string): Promise<Posts> {
    const isValidID = mongoose.isValidObjectId(id)

    const posts = await this.postsModel.findById(id)


    if (!isValidID) {
      throw new BadRequestException('Please enter correct id!')
    }

    if (!posts) {
      throw new NotFoundException('Posts not found!')
    }

    return posts;

  }

  //update the data
  async updatePosts(id: string, posts: Posts): Promise<Posts> {
    return await this.postsModel.findByIdAndUpdate(id, posts, { new: true, runValidators: true, })
  }

  //delete posts by id
  async deletePosts(postsId: string): Promise<void> {
    const result = await this.postsModel.deleteOne({ _id: postsId }).exec();
    if (result.deletedCount === 0) {
      throw new NotFoundException('Post not found');
    }

  }
}
