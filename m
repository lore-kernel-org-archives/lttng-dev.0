From: "Hallsmark, Per" <Per.Hallsmark@windriver.com>
Subject: Re: Sometimes a session destroy hangs
	lttng-consumerd	process
Date: Thu, 10 Sep 2015 06:47:47 +0000
Message-ID: <B7B4BB465792624BAF51F33077E9906578D0DB9A__43912.4707867906$1441867752$gmane$org@ALA-MBA.corp.ad.wrs.com>
References: <B7B4BB465792624BAF51F33077E9906578D0D874@ALA-MBA.corp.ad.wrs.com>,
 <344179387.2171.1441826955184.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.windriver.com ([147.11.1.11])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Per.Hallsmark@windriver.com>) id 1ZZveI-0002o9-CO
 for lttng-dev@lists.lttng.org; Thu, 10 Sep 2015 02:48:00 -0400
In-Reply-To: <344179387.2171.1441826955184.JavaMail.zimbra@efficios.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org



> Hello,
>
> I'm hit by an issue in that when doing session create/destroy multiple ti=
mes,
> during destroy the lttng-consumerd cannot get out of a loop where it want=
s to
> flush metadata, but the connection is probably already down at this stage.
>
> I'm attaching a script that excercise lttng. The issue seems hard to get =
at,
> took 9 hours of running and the script console log looks like:
>
> ....
> Round 4327
> Session s1 created.
> Traces will be written in net://128.224.95.199:53000:53001
> Live timer set to 1000000 usec
> UST channel metadata enabled for session s1
> UST channel c1 enabled for session s1
> All UST events are enabled in channel c1
> Tracing started for session s1
> Waiting for data availability..
> Tracing stopped for session s1
> Session s1 destroyed
> Round 4328
> Session s1 created.
> Traces will be written in net://128.224.95.199:53000:53001
> Live timer set to 1000000 usec
> UST channel metadata enabled for session s1
> UST channel c1 enabled for session s1
> All UST events are enabled in channel c1
> Tracing started for session s1
> libust[14905/14905]: Error: Timed out waiting for lttng-sessiond (in
> lttng_ust_init() at lttng-ust-comm.c:1521)
> < here it hangs >
>
> If I'm now trying a simple "lttng list" or so in target, that also hangs:
>
> root@localhost:~# lttng -vvv list
> DEBUG2 - 10:23:36.911853 [15122/15122]: Session name: (null) (in cmd_list=
() at
> commands/list.c:911)
> DEBUG1 - 10:23:36.913314 [15122/15122]: LSM cmd type : 13 (in send_sessio=
n_msg()
> at lttng-ctl.c:131)
> < here it hangs >
>
> If I start lttng-sessiond to log things:
>
> lttng-sessiond -Z -v -b > lttng-sessiond.log 2>&1
>
> Then I get a huge log where it after some 9 hours shows like:
>
> DEBUG1 - 21:06:53.632585 [3807/3810]: Processing client command 17 (in
> process_client_msg() at main.
> DEBUG3 - 21:06:53.644582 [3807/3813]: Consumer pushing metadata on sock 3=
3 of
> len 686 (in consumer_p
> DEBUG1 - 21:06:53.656539 [3807/3810]: Getting session s1 by name (in
> process_client_msg() at main.c:
> DEBUG1 - 21:06:53.656625 [3823/3829]: UST consumer push metadata key 8658=
 of len
> 686 (in lttng_ustco
> DEBUG1 - 21:06:53.693577 [3823/3829]: Waiting for metadata to be flushed =
(in
> lttng_ustconsumer_recv_
> DEBUG1 - 21:06:53.693585 [3823/3827]: Metadata poll return from wait with=
 2
> fd(s) (in consumer_threa
> DEBUG1 - 21:06:53.847615 [3823/3827]: Metadata event catched in thread (in
> consumer_thread_metadata_
> DEBUG1 - 21:06:53.847642 [3823/3827]: Metadata available on fd 81 (in
> consumer_thread_metadata_poll(
> DEBUG1 - 21:06:54.548885 [3823/3829]: Waiting for metadata to be flushed =
(in
> lttng_ustconsumer_recv_
> DEBUG1 - 21:06:54.264889 [3823/3829]: Waiting for metadata to be flushed =
(in
> lttng_ustconsumer_recv_
> DEBUG1 - 21:06:54.474883 [3823/3829]: Waiting for metadata to be flushed =
(in
> lttng_ustconsumer_recv_
> DEBUG1 - 21:06:54.684874 [3823/3829]: Waiting for metadata to be flushed =
(in
> lttng_ustconsumer_recv_
> DEBUG1 - 21:06:54.894872 [3823/3829]: Waiting for metadata to be flushed =
(in
> lttng_ustconsumer_recv_
> DEBUG1 - 21:06:55.104848 [3823/3829]: Waiting for metadata to be flushed =
(in
> lttng_ustconsumer_recv_
> DEBUG1 - 21:06:55.314850 [3823/3829]: Waiting for metadata to be flushed =
(in
> lttng_ustconsumer_r
>
> After that I only get these "Waiting for metadata to be flushed" lines.
>
> Following the code, I see that area in:
>
> common/ust-consumer/ust-consumer.c::lttng_ustconsumer_recv_metadata() whe=
re
> there is a loop like:
>        while (consumer_metadata_cache_flushed(channel, offset + len, time=
r)) {
>                DBG("Waiting for metadata to be flushed");
>
>                health_code_update();
>
>                usleep(DEFAULT_METADATA_AVAILABILITY_WAIT_TIME);
>        }
>
> So this loop will carry on forever if consumer_metadata_cache_flushed() i=
sn't
> returning 0.
> It seems to me we have some metadata to flush out, but during session des=
troy
> the communication channel is already down so the metadata will never be f=
lushed
> out.
> First thought it may be because consumer_metadata_cache_flushed() is not
> recognizing channel->metadata_stream is down, but perhaps it is the fact =
we
> don't scrap metadata after we have disconnected the channel or so.
> Still trying to follow the code here which is a bit hard for a newcomer.
>
> This has been seen using lttng 2.5.4 / lttng-ust 2.5.5, looking at the la=
test
> master branch (which at time I fetched was commit fb27f84 ) the code
> around this look similar.
>
> I wonder if this is something that has been encountered before? At least a
> comment some lines up in same function suggest it:
>                /*
>                 * Skip metadata flush on write error since the offset and=
 len might
>                 * not have been updated which could create an infinite lo=
op below when
>                 * waiting for the metadata cache to be flushed.
>                 */
>
> But as we unlock metadata_cache and lock it again in the
> consumer_metadata_cache_flushed(), I guess there is a window here when ot=
her
> things could get time todo stuff not thought of.

I ran into this situation in my stress-tests recently, and proposed
the following fix, currently merged in lttng-tools master branch:

commit c585821bc78955b3d747fcd733aa1d2b81a3258e
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date:   Wed Aug 19 14:44:59 2015 -0700

    Fix: sessiond vs consumerd push/get metadata deadlock

    We need to unlock the registry while we push metadata to break a
    circular dependency between the consumerd metadata lock and the sessiond
    registry lock. Indeed, pushing metadata to the consumerd awaits that it
    gets pushed all the way to relayd, but doing so requires grabbing the
    metadata lock. If a concurrent metadata request is being performed by
    consumerd, this can try to grab the registry lock on the sessiond while
    holding the metadata lock on the consumer daemon. Those push and pull
    schemes are performed on two different bidirectionnal communication
    sockets.

    Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
    Signed-off-by: J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.com>

Can you reproduce this issue on the master branch of tools, ust and modules?

Oh gosh, if this solves our issue I must say the lttng issue resolution is =
fast! :-)
I'll see how I can do that. If not able to update to master branch, would t=
he commit
above alone do the work you think?

During night I've been running with a crude workaround like:

diff --git a/src/common/ust-consumer/ust-consumer.c b/src/common/ust-consum=
er/us
t-consumer.c
index f891828..9ded651 100644
--- a/src/common/ust-consumer/ust-consumer.c
+++ b/src/common/ust-consumer/ust-consumer.c
@@ -1026,12 +1026,19 @@ error:
 /*
  * Receive the metadata updates from the sessiond.
  */
+int workaround_verifier=3D1;
 int lttng_ustconsumer_recv_metadata(int sock, uint64_t key, uint64_t offse=
t,
 		uint64_t len, struct lttng_consumer_channel *channel,
 		int timer, int wait)
 {
 	int ret, ret_code =3D LTTCOMM_CONSUMERD_SUCCESS;
 	char *metadata_str;
+	int workaround_counter;
+
+	if (workaround_verifier) {
+		DBG("%s: workaround exist in %s\n", __FILE__, __func__);
+		workaround_verifier=3D0;
+	}
 =

 	DBG("UST consumer push metadata key %" PRIu64 " of len %" PRIu64, key, l
en);
 =

@@ -1072,7 +1079,11 @@ int lttng_ustconsumer_recv_metadata(int sock, uint64=
_t ke
y, uint64_t offset,
 	if (!wait) {
 		goto end_free;
 	}
+	workaround_counter =3D 42;
 	while (consumer_metadata_cache_flushed(channel, offset + len, timer)) {
+		if (!workaround_counter--) {
+			break;
+		}
 		DBG("Waiting for metadata to be flushed");
 =

 		health_code_update();
-- =

1.7.9.5

and it seems to help us get out of the hang, although not fixing why we ent=
ered there.
I'll back that out and try to get your patch in...

Thanks,

Mathieu

>
> Best regards,
> Per
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
