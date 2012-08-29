From: Henrik Hautakoski <henrik@fiktivkod.org>
Subject: Re: More LTTng problems
Date: Wed, 29 Aug 2012 20:59:46 +0200
Message-ID: <CAGya9MkySt-EWaVtqC4jxQwqKXoWWw7FOrwonz+e2Oe9e8Cp0Q__9785.17253320224$1346266823$gmane$org@mail.gmail.com>
References: <CAGya9MmuQi2U6sneqEPwWUrF=1rNNA-zE9yrfneGZ6QBZhBeTg@mail.gmail.com>
	<20120817150806.GA15919@Krystal> <502E6022.60208@efficios.com>
	<CAGya9MmT494LQVy_UfR_50i64-_29bZx+eeSv96Fy+9NzZvJgQ@mail.gmail.com>
	<50324CD4.5050309@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-vc0-f176.google.com ([209.85.220.176])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <henrik@fiktivkod.org>) id 1T6nUV-0001PI-VM
	for lttng-dev@lists.lttng.org; Wed, 29 Aug 2012 14:59:52 -0400
Received: by vcbfl11 with SMTP id fl11so1254209vcb.35
	for <lttng-dev@lists.lttng.org>; Wed, 29 Aug 2012 11:59:46 -0700 (PDT)
In-Reply-To: <50324CD4.5050309@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: David Goulet <dgoulet@efficios.com>
Cc: =?UTF-8?Q?Daniel_Flemstr=C3=B6m?= <daniel.flemstrom@mdh.se>, lttng-dev@lists.lttng.org, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Stefan Karlsson S12 <skn07007@student.mdh.se>
List-Id: lttng-dev@lists.lttng.org

This problem has been fixed. It was a linux-header version missmatch
that caused the consumerd to not being able to connect to the error
socket.

On Mon, Aug 20, 2012 at 4:42 PM, David Goulet <dgoulet@efficios.com> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA512
>
> Hi,
>
> This is pretty odd... it seems the execl() of the consumer failed...
>
> We'll have to confirm this with the perror code I guess. Can you apply
> this patch and re-run again.
>
> diff --git a/src/bin/lttng-sessiond/main.c b/src/bin/lttng-sessiond/main.c
> index c952fc0..d3c378b 100644
> - --- a/src/bin/lttng-sessiond/main.c
> +++ b/src/bin/lttng-sessiond/main.c
> @@ -1782,6 +1782,7 @@ static pid_t spawn_consumerd(struct
> consumer_data *consumer_data)
>                     free(tmpnew);
>                }
>                if (ret) {
> +                   PERROR("execl 32-bit consumer");
>                     goto error;
>                }
>                break;
>
> If you want, to speed things up, you can come on OFTC irc server on
> #lttng and we'll be able to assist you in real time to find this problem.
>
> Cheers
> David
>
> Henrik Hautakoski:
>> Ok so I attached the output from lttng-sessiond (it's large).
>>
>> the commands was:
>>
>> # lttng-sessiond --vvv --no-kernel --verbose-consumer
>>
>> # lttng list -u
>>
>> # lttng create mysession
>>
>> # lttng enable-event -a -u
>>
>> Nothing shows up in dmesg.
>>
>> On Fri, Aug 17, 2012 at 5:15 PM, David Goulet
>> <dgoulet@efficios.com> wrote: Hi,
>>
>> Actually, this error means that a problem occurred *during* the 32
>> bit consumer spawning process... It seems the binary was found but
>> failed to exec it.
>>
>> Running the session daemon (lttng-sessiond) with options "-vvv
>> --verbose-consumer" will help us pin down the problem.
>>
>> Send me back the output, I'll be able to tell you what's going on
>> (and also the series of command you guys did before the
>> enable-event).
>>
>> Last thing, make sure the lttng-consumerd did not segfault (dmesg)
>> or any other lttng-tools component.
>>
>> Thanks! David
>>
>> Mathieu Desnoyers:
>>>>> It looks like you did not build a 32-bit consumer. I'm ccing
>>>>> David Goulet, maintainer of lttng-tools.
>>>>>
>>>>> Thanks,
>>>>>
>>>>> Mathieu
>>>>>
>>>>> * Henrik Hautakoski (henrik@fiktivkod.org) wrote:
>>>>>> Hi. got lttng working now. but when given the following
>>>>>> command, we get an error.
>>>>>>
>>>>>> $ lttng enable-event -a -u Error: Events: 32-bit UST
>>>>>> consumer start failed (channel channel0, session
>>>>>> mysession)
>>>>>>
>>>>>> Could not find any information about this error massage. do
>>>>>> you have any ideas?
>>>>>>
>>>>>> -- Henrik Hautakoski henrik@fiktivkod.org
>>>>>
>>
>>
>>
> -----BEGIN PGP SIGNATURE-----
>
> iQEcBAEBCgAGBQJQMkzRAAoJEELoaioR9I02cTIIAIxjeagCL1uvHB4WT/SGAdOz
> 5eIDXhRyjto+7af4VkjibAozT28XZpnJweWJKkeGJjtRLD/1KFMq06QWREUO6sSz
> NqkU+i+5FHTSCAK4cRS80e0AcqmOCCAo0zfeLpurNCfeu654rHgzk+03XIj+Zn3a
> QhY7Uw9S9SuJ0NPPP6f50bmlsdh6VGLHmJQMi2nNJQZPFiuwLHF9V7mUOO66ZWqF
> ikqN5NGDMsmjOoY7XPwcalF7BK1vq9bMv+f9zyWImFV/ky8iHw0d1Cemy9O1cWw1
> cbM1wyEqzfDV5QIoFqa0ZKIsbuUzuwy4/bkk7pTrqOaTDLuwOOoqYs108yeJgUg=
> =mDFB
> -----END PGP SIGNATURE-----



-- 
Henrik Hautakoski
henrik@fiktivkod.org
