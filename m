From: Alexandre Montplaisir <alexmonthy@voxpopuli.im>
Subject: Re: [PATCH lttng-tool] Mi & save/load: add option to
 indent or not on config writer creation
Date: Wed, 06 Aug 2014 11:34:39 -0400
Message-ID: <53E24B0F.5000002__29222.8367332884$1407339349$gmane$org@voxpopuli.im>
References: <1407334428-7601-1-git-send-email-jonathan.r.julien@gmail.com>
 <CAFXXi0nEyJzZ4YJv-pw7hPJfRq7LzzuLWG-_TrChpa8er1cqKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.181])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <alexmonthy@voxpopuli.im>) id 1XF3Ee-0001Op-Ia
 for lttng-dev@lists.lttng.org; Wed, 06 Aug 2014 11:34:46 -0400
In-Reply-To: <CAFXXi0nEyJzZ4YJv-pw7hPJfRq7LzzuLWG-_TrChpa8er1cqKA@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Simon Marchi <simon.marchi@polymtl.ca>, Jonathan Rajotte Julien <jonathan.r.julien@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org


On 08/06/2014 10:49 AM, Simon Marchi wrote:
> On 6 August 2014 10:13, Jonathan Rajotte Julien
> <jonathan.r.julien@gmail.com> wrote:
>> The presence of tabulation and newline in mi is irrelevant and
>> can impact client performance. The parsing & processing of a lot of data from mi
>> with many /t and /n impact performance. This aim to fix the problem at the
>> source. Style is useless for machine.
> Just by curiosity, did you manage to put a number on that performance impact?

50

>
>> Signed-off-by: Jonathan Rajotte Julien <jonathan.r.julien@gmail.com>
>> ---
>>   src/bin/lttng-sessiond/save.c | 2 +-
>>   src/common/config/config.c    | 8 ++++----
>>   src/common/config/config.h    | 5 ++++-
>>   src/common/mi-lttng.c         | 2 +-
>>   4 files changed, 10 insertions(+), 7 deletions(-)
>>
>> diff --git a/src/bin/lttng-sessiond/save.c b/src/bin/lttng-sessiond/save.c
>> index 90b3a3b..28844e3 100644
>> --- a/src/bin/lttng-sessiond/save.c
>> +++ b/src/bin/lttng-sessiond/save.c
>> @@ -1514,7 +1514,7 @@ int save_session(struct ltt_session *session,
>>          }
>>          file_opened = 1;
>>
>> -       writer = config_writer_create(fd);
>> +       writer = config_writer_create(fd, 1);
>>          if (!writer) {
>>                  ret = LTTNG_ERR_NOMEM;
>>                  goto end;
>> diff --git a/src/common/config/config.c b/src/common/config/config.c
>> index bfb2576..1dccd26 100644
>> --- a/src/common/config/config.c
>> +++ b/src/common/config/config.c
>> @@ -353,7 +353,7 @@ end:
>>   }
>>
>>   LTTNG_HIDDEN
>> -struct config_writer *config_writer_create(int fd_output)
>> +struct config_writer *config_writer_create(int fd_output, int indent)
>>   {
>>          int ret;
>>          struct config_writer *writer;
>> @@ -379,12 +379,12 @@ struct config_writer *config_writer_create(int fd_output)
>>
>>          ret = xmlTextWriterSetIndentString(writer->writer,
>>                  BAD_CAST config_xml_indent_string);
>> -       if (ret)  {
>> +       if (ret) {
>>                  goto error_destroy;
>>          }
>>
>> -       ret = xmlTextWriterSetIndent(writer->writer, 1);
>> -       if (ret)  {
>> +       ret = xmlTextWriterSetIndent(writer->writer, indent);
>> +       if (ret) {
>>                  goto error_destroy;
>>          }
>>
>> diff --git a/src/common/config/config.h b/src/common/config/config.h
>> index 9a5671a..2fed612 100644
>> --- a/src/common/config/config.h
>> +++ b/src/common/config/config.h
>> @@ -81,11 +81,14 @@ int config_parse_value(const char *value);
>>    * fd_output File to which the XML content must be written. The file will be
>>    * closed once the config_writer has been destroyed.
>>    *
>> + * indent If other than 0 the XML will be pretty printed
>> + * with indentation and newline.
>> + *
>>    * Returns an instance of a configuration writer on success, NULL on
>>    * error.
>>    */
>>   LTTNG_HIDDEN
>> -struct config_writer *config_writer_create(int fd_output);
>> +struct config_writer *config_writer_create(int fd_output, int indent);
>>
>>   /*
>>    * Destroy an instance of a configuration writer.
>> diff --git a/src/common/mi-lttng.c b/src/common/mi-lttng.c
>> index a636c71..31fa610 100644
>> --- a/src/common/mi-lttng.c
>> +++ b/src/common/mi-lttng.c
>> @@ -352,7 +352,7 @@ struct mi_writer *mi_lttng_writer_create(int fd_output, int mi_output_type)
>>                  goto end;
>>          }
>>          if (mi_output_type == LTTNG_MI_XML) {
>> -               mi_writer->writer = config_writer_create(fd_output);
>> +               mi_writer->writer = config_writer_create(fd_output, 0);
>>                  if (!mi_writer->writer) {
>>                          goto err_destroy;
>>                  }
>> --
>> 2.0.0
>>
>>
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
