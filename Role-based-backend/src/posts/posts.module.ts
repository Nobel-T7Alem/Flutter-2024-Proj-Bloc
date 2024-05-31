import { Module } from '@nestjs/common';
import { PostsController } from './posts.controller';
import { PostsService } from './posts.service';
import { Posts, PostsSchema } from './schemas/posts.schema';
import { MongooseModule } from '@nestjs/mongoose';
import { AuthModule } from 'src/auth/auth.module';

@Module({
  imports: [
    AuthModule,
    MongooseModule.forFeature([{name:'posts', schema:PostsSchema}])
  ],
  controllers: [PostsController],
  providers: [PostsService],
})
export class PostsModule {}
