import { Injectable, NotFoundException } from '@nestjs/common';
import { CreateCalendarDto } from './dto/create-calendar.dto';
import { UpdateCalendarDto } from './dto/update-calendar.dto';
import { Model } from 'mongoose';
import { InjectModel } from '@nestjs/mongoose';
import { Calendars } from './schema/calendar.schema';
import { User } from 'src/user/schemas/user.schema';

@Injectable()
export class CalendarsService {
  constructor(
    @InjectModel('calendars') private readonly calendarsModel: Model<Calendars>,
  ) { }

  async createEvent(createEventDto: CreateCalendarDto, postId: string, user: User): Promise<Calendars> {
    const createdEvent = new this.calendarsModel({
      ...createEventDto,
      post: postId,
      user: user,
    });
    return createdEvent.save();
  }

  async findAllByUser(userId: string): Promise<Calendars[]> {
    return this.calendarsModel.find({ user: userId }).exec();
  }

  findOne(id: number) {
    return `This action returns a #${id} calendar`;
  }

  async updateCalendar(id: string, updateCalendarDto: UpdateCalendarDto): Promise<Calendars> {
    const updatedCalendar = await this.calendarsModel
      .findByIdAndUpdate(id, updateCalendarDto, { new: true, runValidators: true })
      .exec();
    if (!updatedCalendar) {
      throw new NotFoundException("Calendar event with ID ${id} not found");
    }
    return updatedCalendar;
  }

  async remove(id: string) {
    const result = await this.calendarsModel.deleteOne({ _id: id }).exec();
    if (result.deletedCount === 0) {
      throw new NotFoundException('Calendar not found');
    }
  }
}
