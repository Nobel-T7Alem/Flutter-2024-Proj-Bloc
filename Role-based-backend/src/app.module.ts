import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { MongooseModule } from '@nestjs/mongoose';
import { AuthModule } from './auth/auth.module';
import { PostsModule } from './posts/posts.module';
import { UserModule } from './user/user.module';
import { CalendarsModule } from './calendars/calendars.module';



@Module({
  imports: [
    MongooseModule.forRoot("mongodb://127.0.0.1:27017", {
      dbName: 'Sebawi-app',
    }),
    AuthModule,
    PostsModule,
    UserModule,
    CalendarsModule,

  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule { }
