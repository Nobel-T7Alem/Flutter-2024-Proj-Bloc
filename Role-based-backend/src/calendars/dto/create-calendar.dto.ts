import { IsDateString, IsNotEmpty } from 'class-validator';

export class CreateCalendarDto {
  @IsNotEmpty()
  @IsDateString()
  date: Date;
  
}