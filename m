From: Zifei Tong <soariez@gmail.com>
Subject: Re: [PATCH lttng-tools] Fix: memory leak when UST
 events are enabled with exclusions
Date: Fri, 31 Jan 2014 22:38:51 +0800
Message-ID: <CAJ7wx-Fz9cBNpMoUz61uA=pi0FL09qj3a60prSRMqOLjyPpezw__37257.3590175763$1391179239$gmane$org@mail.gmail.com>
References: <1390240272-16029-1-git-send-email-jeremie.galarneau@efficios.com>
	<1633494270.16038.1391122775911.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ve0-f178.google.com ([209.85.128.178])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <soariez@gmail.com>) id 1W9FFp-0003go-3J
	for lttng-dev@lists.lttng.org; Fri, 31 Jan 2014 09:39:43 -0500
Received: by mail-ve0-f178.google.com with SMTP id oy12so3251898veb.9
	for <lttng-dev@lists.lttng.org>; Fri, 31 Jan 2014 06:39:31 -0800 (PST)
In-Reply-To: <1633494270.16038.1391122775911.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

I have to apply this patch onto J=E9r=E9mie's one to bypass a double free
error in unit test.

diff --git a/tests/unit/test_ust_data.c b/tests/unit/test_ust_data.c
index 52b93e9..92f8771 100644
--- a/tests/unit/test_ust_data.c
+++ b/tests/unit/test_ust_data.c
@@ -172,7 +172,6 @@ static void test_create_ust_event_exclusion(void)
           event->attr.name[LTTNG_UST_SYM_NAME_LEN - 1] =3D=3D '\0',
           "Validate UST event and exclusion");

-       free(exclusion);
        trace_ust_destroy_event(event);
 }

--
Best Regards,
Zifei Tong


On Fri, Jan 31, 2014 at 6:59 AM, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
> David: this needs to be merged.
>
> Acked-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>
> Thanks,
>
> Mathieu
>
> ----- Original Message -----
>> From: "J=E9r=E9mie Galarneau" <jeremie.galarneau@efficios.com>
>> To: lttng-dev@lists.lttng.org
>> Sent: Monday, January 20, 2014 12:51:12 PM
>> Subject: [lttng-dev] [PATCH lttng-tools] Fix: memory leak when UST event=
s     are enabled with exclusions
>>
>> Signed-off-by: J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.com>
>> ---
>>  src/bin/lttng-sessiond/trace-ust.c | 1 +
>>  src/bin/lttng-sessiond/trace-ust.h | 2 +-
>>  2 files changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/src/bin/lttng-sessiond/trace-ust.c
>> b/src/bin/lttng-sessiond/trace-ust.c
>> index 70b3a91..c08246a 100644
>> --- a/src/bin/lttng-sessiond/trace-ust.c
>> +++ b/src/bin/lttng-sessiond/trace-ust.c
>> @@ -504,6 +504,7 @@ void trace_ust_destroy_event(struct ltt_ust_event *e=
vent)
>>
>>       DBG2("Trace destroy UST event %s", event->attr.name);
>>       free(event->filter);
>> +     free(event->exclusion);
>>       free(event);
>>  }
>>
>> diff --git a/src/bin/lttng-sessiond/trace-ust.h
>> b/src/bin/lttng-sessiond/trace-ust.h
>> index f2f8c7e..07af0f1 100644
>> --- a/src/bin/lttng-sessiond/trace-ust.h
>> +++ b/src/bin/lttng-sessiond/trace-ust.h
>> @@ -50,7 +50,7 @@ struct ltt_ust_event {
>>       struct lttng_ust_event attr;
>>       struct lttng_ht_node_str node;
>>       struct lttng_ust_filter_bytecode *filter;
>> -     const struct lttng_event_exclusion *exclusion;
>> +     struct lttng_event_exclusion *exclusion;
>>  };
>>
>>  /* UST channel */
>> --
>> 1.8.5.2
>>
>>
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
