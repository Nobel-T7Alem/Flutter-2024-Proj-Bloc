import { Module } from '@nestjs/common';
import { CalendarsService } from './calendars.service';
import { CalendarsController } from './calendars.controller';
import { MongooseModule } from '@nestjs/mongoose';
import { CalendarsSchema } from './schema/calendar.schema';
import { AuthModule } from 'src/auth/auth.module';

@Module({
  imports: [
    AuthModule,
    MongooseModule.forFeature([{name:'calendars', schema:CalendarsSchema}])
  ],
  controllers: [CalendarsController],
  providers: [CalendarsService],
})
export class CalendarsModule {}
