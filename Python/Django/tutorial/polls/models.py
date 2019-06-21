from django.db import models
from django.utils import timezone
import datetime


class Question(models.Model):
    question_text = models.CharField(max_length=200)
    pub_date = models.DateTimeField('发布日期')

    def __str__(self):
        question = {
            'id': self.id,
            'text': self.question_text,
            'date': self.pub_date.strftime("%Y-%m-%d")
        }

        return str(question)

    def was_published_recently(self):
        now = timezone.now()
        return now - datetime.timedelta(days=1) <= self.pub_date <= now

    was_published_recently.admin_order_field = 'pub_date'
    was_published_recently.boolean = True
    was_published_recently.short_description = 'Published recently?'


class Choice(models.Model):
    question = models.ForeignKey(Question, on_delete=models.CASCADE)
    choice_text = models.CharField(max_length=200)
    votes = models.IntegerField(default=0)

    def __str__(self):
        choice = {
            'id': self.id,
            'question': self.question.id,
            'text': self.choice_text,
            'votes': self.votes
        }
        return str(choice)
