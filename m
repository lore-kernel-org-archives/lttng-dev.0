From: Philippe Proulx <eeppeliteloop@gmail.com>
Subject: Re: [lttng-tools] Fix: channel name with '.' and '/'
 brings problems
Date: Wed, 26 Nov 2014 23:59:47 -0500
Message-ID: <CAB4xu_01LPaLU3vrXKz-UJMjpjkWzVKQrc6MX1LR1MBTp3E+pA__9084.52945664084$1417064465$gmane$org@mail.gmail.com>
References: <1417059132-14298-1-git-send-email-eeppeliteloop@gmail.com>
 <CAF4oYfGk8mWnBU3OdTNFXJxXfHFB-G1mOWciLGb-27qvskEKPA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lb0-f170.google.com ([209.85.217.170])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <eeppeliteloop@gmail.com>) id 1XtrBn-0005e4-R6
 for lttng-dev@lists.lttng.org; Thu, 27 Nov 2014 00:00:26 -0500
Received: by mail-lb0-f170.google.com with SMTP id w7so3594823lbi.15
 for <lttng-dev@lists.lttng.org>; Wed, 26 Nov 2014 21:00:18 -0800 (PST)
In-Reply-To: <CAF4oYfGk8mWnBU3OdTNFXJxXfHFB-G1mOWciLGb-27qvskEKPA@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jonathan Rajotte <jonathan.r.julien@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On Wed, Nov 26, 2014 at 10:46 PM, Jonathan Rajotte
<jonathan.r.julien@gmail.com> wrote:
> Hey Phil,
>
> Not sure if modifying user input without any warnings about it is a good
> idea. This clearly solve problems but do we want to solve it this way ?
>
> It might be a better idea to warn the user about improper channel name or
> simply block the command and return an error.

Hi Jo,

I think you are right. I forgot to write about this, but I thought
about it, and I think too
that it's a good idea. The only reason I didn't add warnings was that
the user input
is already (potentially) modified without warnings:

    strncpy(chan.name, channel_name, NAME_MAX);
    chan.name[NAME_MAX - 1] = '\0';

That is, channel names are truncated to (NAME_MAX - 1) characters:

    lttng enable-channel -k aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\
    aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\
    aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\
    aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\
    aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\
    aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\
    aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\
    aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\
    aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa

The effective channel name is 254 'a's.

So, first question: should the name be modified at all, or should an
error be displayed
when the name is invalid? I'm in favor of the second option.

Second question: if an error is to be displayed, should the validation
happen in the
lttng CLI or in the session daemon? I'm in favor of the second option,
as, for example,
session names are currently validaded on the session daemon side, which is legit
since validation should be done by the model ultimately.

I'll let the maintainer decide whatever is the best direction for
this. Honestly, I was
expecting a nack for this patch, which is more a discussion starter
than anything
else ;-)

Phil
>
> On Wed, Nov 26, 2014 at 10:32 PM, Philippe Proulx <eeppeliteloop@gmail.com>
> wrote:
>>
>> This patch ensures:
>>
>>   1. A channel name does not contain any '/' character, since
>>      relative paths may be injected in the channel name
>>      otherwise (knowing that the channel name is eventually
>>      part of a file name)
>>   2. A channel name does not start with a '.' character, since
>>      trace readers (Babeltrace is one of them) could interpret
>>      files starting with a dot as hidden files and ignore
>>      them when opening the CTF trace
>>
>> Fixes: #751
>>
>> Signed-off-by: Philippe Proulx <eeppeliteloop@gmail.com>
>> ---
>>  src/bin/lttng/commands/enable_channels.c | 38
>> +++++++++++++++++++++++++++-----
>>  1 file changed, 33 insertions(+), 5 deletions(-)
>>
>> diff --git a/src/bin/lttng/commands/enable_channels.c
>> b/src/bin/lttng/commands/enable_channels.c
>> index f8272e9..e6cce49 100644
>> --- a/src/bin/lttng/commands/enable_channels.c
>> +++ b/src/bin/lttng/commands/enable_channels.c
>> @@ -275,11 +275,39 @@ static int enable_channel(char *session_name)
>>         /* Strip channel list (format: chan1,chan2,...) */
>>         channel_name = strtok(opt_channels, ",");
>>         while (channel_name != NULL) {
>> -               /* Copy channel name and normalize it */
>> +               /* Copy channel name, sanitize and normalize it */
>>                 strncpy(chan.name, channel_name, NAME_MAX);
>>                 chan.name[NAME_MAX - 1] = '\0';
>>
>> -               DBG("Enabling channel %s", channel_name);
>> +               char *src, *dst;
>> +               int got_first = 0;
>> +
>> +               for (src = dst = chan.name; *src != '\0'; ++src) {
>> +                       *dst = *src;
>> +
>> +                       /*
>> +                        * Channel name could be used in file names, so
>> remove
>> +                        * invalid '/'
>> +                        */
>> +                       if (*dst != '/') {
>
>
> Maybe send some warning here ?
>
>>
>> +                               /*
>> +                                * Remove starting dots since this could
>> create
>> +                                * file names starting with dots, and
>> trace
>> +                                * readers could interpret them as hidden
>> files
>> +                                * and ignore them.
>> +                                */
>> +                               if (*dst != '.') {
>
>
> Same
>
>>
>> +                                       got_first = 1;
>> +                                       dst++;
>> +                               } else if (got_first) {
>> +                                       dst++;
>> +                               }
>> +                       }
>> +               }
>> +
>> +               *dst = '\0';
>> +
>> +               DBG("Enabling channel %s", chan.name);
>>
>>                 ret = lttng_enable_channel(handle, &chan);
>>                 if (ret < 0) {
>> @@ -288,19 +316,19 @@ static int enable_channel(char *session_name)
>>                         case LTTNG_ERR_KERN_CHAN_EXIST:
>>                         case LTTNG_ERR_UST_CHAN_EXIST:
>>                         case LTTNG_ERR_CHAN_EXIST:
>> -                               WARN("Channel %s: %s (session %s)",
>> channel_name,
>> +                               WARN("Channel %s: %s (session %s)",
>> chan.name,
>>                                                 lttng_strerror(ret),
>> session_name);
>>                                 warn = 1;
>>                                 break;
>>                         default:
>> -                               ERR("Channel %s: %s (session %s)",
>> channel_name,
>> +                               ERR("Channel %s: %s (session %s)",
>> chan.name,
>>                                                 lttng_strerror(ret),
>> session_name);
>>                                 error = 1;
>>                                 break;
>>                         }
>>                 } else {
>>                         MSG("%s channel %s enabled for session %s",
>> -                                       get_domain_str(dom.type),
>> channel_name, session_name);
>> +                                       get_domain_str(dom.type),
>> chan.name, session_name);
>>                         success = 1;
>>                 }
>>
>> --
>> 2.1.3
>>
>>
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
>
>
>
> --
> Jonathan Rajotte Julien
