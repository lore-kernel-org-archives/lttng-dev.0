From: Stanislav Vovk <stanislav.vovk@ericsson.com>
Subject: Re: one sessiond for multiuser system
Date: Mon, 12 Aug 2013 12:31:30 +0000
Message-ID: <6DB83340B9D38C4A9C0ECD8B6FBABDFB1A22CB27__20861.2661961981$1376310745$gmane$org@ESESSMB105.ericsson.se>
References: <6DB83340B9D38C4A9C0ECD8B6FBABDFB1A223B68@ESESSMB105.ericsson.se>
	<CA+jJMxuJ2itGEqM0Y7VLabttNuwfogD448bUEPtQeuoz_RpWyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mailgw2.ericsson.se ([193.180.251.37])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <stanislav.vovk@ericsson.com>) id 1V8rHY-0003hl-R7
	for lttng-dev@lists.lttng.org; Mon, 12 Aug 2013 08:31:35 -0400
In-Reply-To: <CA+jJMxuJ2itGEqM0Y7VLabttNuwfogD448bUEPtQeuoz_RpWyA@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?iso-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi,

No, "Bob" did not belong to group "tracing"!

I created group "tracing", added Bob to it(as secondary group, "users" is p=
rimary) and could successfully see all events registered by program run as =
Bob. Thanks for that!
One problem though, when I took a snapshot with "lttng snapshot record" con=
sumerd crashed! See below for debug output from sessiond. Seems like a bug =
to me, something to add to the bugtracker?

Cheers,
Stanislav

DEBUG1 [2056/2061]: Sending metadata request to sessiond, session id 0, per=
-pid 6 (in lttng_ustconsumer_request_metadata() at ust-consumer.c:1867)
DEBUG1 [1855/2057]: Metadata request received for session 0, key 8 (in ust_=
consumer_metadata_request() at ust-consumer.c:455)
DEBUG3 [1855/2057]: Buffer registry per UID find id: 0, ABI: 32, uid: 0 (in=
 buffer_reg_uid_find() at buffer-registry.c:195)
DEBUG3 [1855/2057]: No metadata to push for metadata key 4 (in ust_app_push=
_metadata() at ust-app.c:441)
DEBUG1 [1855/2057]: No metadata to push (in ust_app_push_metadata() at ust-=
app.c:444)
DEBUG2 [1855/2057]: Consumer push metadata to consumer socket 33 (in consum=
er_push_metadata() at consumer.c:1175)
lttng-consumerd: ust-consumer.c:1907: lttng_ustconsumer_request_metadata: A=
ssertion `key =3D=3D channel->key' failed.
DEBUG1 [1855/1858]: Fail to receive status reply on sock 32 (in consumer_re=
cv_status_reply() at consumer.c:58)
DEBUG1 [1855/1858]: Sending response (size: 16, retcode: Snapshot record fa=
iled) (in thread_manage_clients() at main.c:3765)
DEBUG1 [1855/2057]: Fail to receive status reply on sock 33 (in consumer_re=
cv_status_reply() at consumer.c:58)
Error: Pushing metadata
Error: Handling metadata request
Error: Health error occurred in thread_manage_consumer
DEBUG1 [1855/2057]: consumer thread cleanup completed (in thread_manage_con=
sumer() at main.c:1194)
DEBUG1 [1855/1858]: Clean command context structure (in clean_command_ctx()=
 at main.c:538)
DEBUG1 [1855/1858]: Accepting client command ... (in thread_manage_clients(=
) at main.c:3629)  =



-----Original Message-----
From: jeremie.galarneau@gmail.com [mailto:jeremie.galarneau@gmail.com] On B=
ehalf Of J=E9r=E9mie Galarneau
Sent: den 9 augusti 2013 16:55
To: Stanislav Vovk
Cc: lttng-dev@lists.lttng.org
Subject: Re: [lttng-dev] one sessiond for multiuser system

On Fri, Aug 9, 2013 at 4:01 AM, Stanislav Vovk <stanislav.vovk@ericsson.com=
> wrote:
> Hi,
>
> Have a few questions regarding lttng configuration in a multi user system.
>
> In my system there are two users, root and Bob. I am starting sessiond at=
 boot as root user. And instrumented programs are started as either root or=
 Bob. I am logged in to the system and controlling lttng as root user.
>
> - When executing "lttng list -u" I see events registered by programs star=
ted as root. I don't see events from programs started as Bob. Why? Did I fo=
rget something?
>
> - Now I switch user to Bob in the shell. Executing "lttng list -u" does n=
ot give any output at all, instead a new sessiond is started. How can I hav=
e one sessiond for the whole system?

Hi Stanislav,

A non-privileged user can only interact with a root session daemon if he is=
 part of the "tracing" group. Is it the case for "Bob" in this example?

Reproducing your scenario here with "Bob" being part of the tracing group:
- Root can list its own sessions as well as Bob's
- Bob's user space events can also be seen by root
- Bob can't see the sessions created by root.

Regards,
J=E9r=E9mie

>
> Cheers,
> Stanislav
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev



--
J=E9r=E9mie Galarneau
EfficiOS Inc.
http://www.efficios.com
