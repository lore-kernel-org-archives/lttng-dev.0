From: Yannick Brosseau <yannick.brosseau@gmail.com>
Subject: Re: [PATCH] lttng-gen-tp: remove support for # comments
Date: Tue, 25 Jun 2013 11:02:06 -0400
Message-ID: <51C9B0EE.90300__9386.09855152226$1372172575$gmane$org@gmail.com>
References: <1371577764-7740-1-git-send-email-romain.lenglet@berabera.info>
	<51C0B72F.2080404@gmail.com>
	<A8D5A8E4-C2A2-4917-A6F1-0FE6C8BC115D@berabera.info>
	<51C5E479.9060502@gmail.com>
	<3C7142A8-A34C-4860-8451-3C99C02F417D@berabera.info>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-oa0-f49.google.com ([209.85.219.49])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <yannick.brosseau@gmail.com>) id 1UrUl9-0001jj-My
	for lttng-dev@lists.lttng.org; Tue, 25 Jun 2013 11:02:19 -0400
Received: by mail-oa0-f49.google.com with SMTP id n9so13687282oag.36
	for <lttng-dev@lists.lttng.org>; Tue, 25 Jun 2013 08:02:14 -0700 (PDT)
In-Reply-To: <3C7142A8-A34C-4860-8451-3C99C02F417D@berabera.info>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Romain Lenglet <romain.lenglet@berabera.info>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

On 2013-06-23 15:38, Romain Lenglet wrote:
> Hi Yannick,
>
> Your change does the job, thanks!
>
> However, the regular expression "#[^include].*$" is incorrect, as [] matches a set of characters.
> For instance, '#not an include' is not removed as you intended, as '#' is followed by 'n'.
>
> I'd suggest using this regular expression instead:
> '#(?!include).*$'
Yeah, good point, I did it really quickly. I'll send a fix soon (with
more test)

>
> Thanks,
> --
> Romain Lenglet
>
> On Jun 22, 2013, at 10:52 AM, Yannick Brosseau <yannick.brosseau@gmail.com> wrote:
>
>> Hi,
>>
>> I hope the latest commit on lttng-gen-tp which allows to add #include to
>> the .tp will be an appropriate fix for your needs
>>
>> On 2013-06-18 17:22, Romain Lenglet wrote:
>>> I need to use non-trivial types in TP_ARGS, e.g. uint64_t, or custom C++ classes.
>>> In the latter case, the motivation is to call accessors on C++ objects only when actually tracing, in TP_FIELDS.
>>> This absolutely requires including standard header files such as stdint.h, or header files defining C++ classes.
>>>
>>> What other solutions would you suggest to cleanly enable users to include header files from .tp files?
>>>
>>> Regards,
>>> --
>>> Romain Lenglet
>>>
>>> On Jun 18, 2013, at 12:38 PM, Yannick Brosseau <yannick.brosseau@gmail.com> wrote:
>>>
>>>> On 2013-06-18 13:49, Romain Lenglet wrote:
>>>>> Support #define, #include, etc. in tracepoint files.
>>>> Do you have a specific use case that demonstrate the need for that?
>>>>
>>>> The design goal of lttng-gen-tp included generating tracepoints for
>>>> other language than C, so we wanted a format more agnostics hence the
>>>> support for # comments
>>>>
>>>>> Signed-off-by: Romain Lenglet <romain.lenglet@berabera.info>
>>>>> ---
>>>>> doc/man/lttng-gen-tp.1 |    2 +-
>>>>> tools/lttng-gen-tp     |    3 ---
>>>>> 2 files changed, 1 insertion(+), 4 deletions(-)
>>>>>
>>>>> diff --git a/doc/man/lttng-gen-tp.1 b/doc/man/lttng-gen-tp.1
>>>>> index 84c05c9..96f02c4 100644
>>>>> --- a/doc/man/lttng-gen-tp.1
>>>>> +++ b/doc/man/lttng-gen-tp.1
>>>>> @@ -64,7 +64,7 @@ TRACEPOINT_LOGLEVEL.
>>>>> (See lttng-ust(3) for the complete list of available definition.)
>>>>>
>>>>> You write them as you would write them in a C header file. You can add
>>>>> -comments with \fB/* */\fP, \fB//\fP and \fB#\fP.
>>>>> +comments with \fB/* */\fP and \fB//\fP.
>>>>>
>>>>> The provider name (the first field of TRACEPOINT_EVENT) must be
>>>>> the same for the whole file.
>>>>> diff --git a/tools/lttng-gen-tp b/tools/lttng-gen-tp
>>>>> index 5937dfd..5ea221b 100755
>>>>> --- a/tools/lttng-gen-tp
>>>>> +++ b/tools/lttng-gen-tp
>>>>> @@ -159,9 +159,6 @@ class TemplateFile:
>>>>>
>>>>>        self.text = f.read()
>>>>>
>>>>> -        #Remove # comments (from input and output file
>>>>> -        removeComments = re.compile("#.*$",flags=re.MULTILINE)
>>>>> -        self.text = removeComments.sub("",self.text)
>>>>>        #Remove // comments
>>>>>        removeLineComment = re.compile("\/\/.*$",flags=re.MULTILINE)
>>>>>        nolinecomment = removeLineComment.sub("",self.text)
>>
