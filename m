From: "Hallsmark, Per" <Per.Hallsmark@windriver.com>
Subject: Sometimes a session destroy hangs lttng-consumerd
	process
Date: Wed, 9 Sep 2015 12:23:39 +0000
Message-ID: <B7B4BB465792624BAF51F33077E9906578D0D874__49246.622020337$1441801496$gmane$org@ALA-MBA.corp.ad.wrs.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="_002_B7B4BB465792624BAF51F33077E9906578D0D874ALAMBAcorpadwrs_"
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail1.windriver.com ([147.11.146.13])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Per.Hallsmark@windriver.com>) id 1ZZePj-0005XK-Ky
 for lttng-dev@lists.lttng.org; Wed, 09 Sep 2015 08:23:50 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
 [147.11.189.40])
 by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id t89CNfJQ025501
 (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
 for <lttng-dev@lists.lttng.org>; Wed, 9 Sep 2015 05:23:41 -0700 (PDT)
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--_002_B7B4BB465792624BAF51F33077E9906578D0D874ALAMBAcorpadwrs_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello,

I'm hit by an issue in that when doing session create/destroy multiple time=
s, during destroy the lttng-consumerd cannot get out of a loop where it wan=
ts to flush metadata, but the connection is probably already down at this s=
tage.

I'm attaching a script that excercise lttng. The issue seems hard to get at=
, took 9 hours of running and the script console log looks like:

....
Round 4327
Session s1 created.
Traces will be written in net://128.224.95.199:53000:53001
Live timer set to 1000000 usec
UST channel metadata enabled for session s1
UST channel c1 enabled for session s1
All UST events are enabled in channel c1
Tracing started for session s1
Waiting for data availability..
Tracing stopped for session s1
Session s1 destroyed
Round 4328
Session s1 created.
Traces will be written in net://128.224.95.199:53000:53001
Live timer set to 1000000 usec
UST channel metadata enabled for session s1
UST channel c1 enabled for session s1
All UST events are enabled in channel c1
Tracing started for session s1
libust[14905/14905]: Error: Timed out waiting for lttng-sessiond (in lttng_=
ust_init() at lttng-ust-comm.c:1521)
< here it hangs >

If I'm now trying a simple "lttng list" or so in target, that also hangs:

root@localhost:~# lttng -vvv list
DEBUG2 - 10:23:36.911853 [15122/15122]: Session name: (null) (in cmd_list()=
 at commands/list.c:911)
DEBUG1 - 10:23:36.913314 [15122/15122]: LSM cmd type : 13 (in send_session_=
msg() at lttng-ctl.c:131)
< here it hangs >

If I start lttng-sessiond to log things:

lttng-sessiond -Z -v -b > lttng-sessiond.log 2>&1

Then I get a huge log where it after some 9 hours shows like:

DEBUG1 - 21:06:53.632585 [3807/3810]: Processing client command 17 (in proc=
ess_client_msg() at main.
DEBUG3 - 21:06:53.644582 [3807/3813]: Consumer pushing metadata on sock 33 =
of len 686 (in consumer_p
DEBUG1 - 21:06:53.656539 [3807/3810]: Getting session s1 by name (in proces=
s_client_msg() at main.c:
DEBUG1 - 21:06:53.656625 [3823/3829]: UST consumer push metadata key 8658 o=
f len 686 (in lttng_ustco
DEBUG1 - 21:06:53.693577 [3823/3829]: Waiting for metadata to be flushed (i=
n lttng_ustconsumer_recv_
DEBUG1 - 21:06:53.693585 [3823/3827]: Metadata poll return from wait with 2=
 fd(s) (in consumer_threa
DEBUG1 - 21:06:53.847615 [3823/3827]: Metadata event catched in thread (in =
consumer_thread_metadata_
DEBUG1 - 21:06:53.847642 [3823/3827]: Metadata available on fd 81 (in consu=
mer_thread_metadata_poll(
DEBUG1 - 21:06:54.548885 [3823/3829]: Waiting for metadata to be flushed (i=
n lttng_ustconsumer_recv_
DEBUG1 - 21:06:54.264889 [3823/3829]: Waiting for metadata to be flushed (i=
n lttng_ustconsumer_recv_
DEBUG1 - 21:06:54.474883 [3823/3829]: Waiting for metadata to be flushed (i=
n lttng_ustconsumer_recv_
DEBUG1 - 21:06:54.684874 [3823/3829]: Waiting for metadata to be flushed (i=
n lttng_ustconsumer_recv_
DEBUG1 - 21:06:54.894872 [3823/3829]: Waiting for metadata to be flushed (i=
n lttng_ustconsumer_recv_
DEBUG1 - 21:06:55.104848 [3823/3829]: Waiting for metadata to be flushed (i=
n lttng_ustconsumer_recv_
DEBUG1 - 21:06:55.314850 [3823/3829]: Waiting for metadata to be flushed (i=
n lttng_ustconsumer_r

After that I only get these "Waiting for metadata to be flushed" lines.

Following the code, I see that area in:

common/ust-consumer/ust-consumer.c::lttng_ustconsumer_recv_metadata() where=
 there is a loop like:
        while (consumer_metadata_cache_flushed(channel, offset + len, timer=
)) {
                DBG("Waiting for metadata to be flushed");

                health_code_update();

                usleep(DEFAULT_METADATA_AVAILABILITY_WAIT_TIME);
        }

So this loop will carry on forever if consumer_metadata_cache_flushed() isn=
't returning 0.
It seems to me we have some metadata to flush out, but during session destr=
oy the communication channel is already down so the metadata will never be =
flushed out.
First thought it may be because consumer_metadata_cache_flushed() is not re=
cognizing channel->metadata_stream is down, but perhaps it is the fact we d=
on't scrap metadata after we have disconnected the channel or so.
Still trying to follow the code here which is a bit hard for a newcomer.

This has been seen using lttng 2.5.4 / lttng-ust 2.5.5, looking at the late=
st master branch (which at time I fetched was commit fb27f84 ) the code
around this look similar.

I wonder if this is something that has been encountered before? At least a =
comment some lines up in same function suggest it:
                /*
                 * Skip metadata flush on write error since the offset and =
len might
                 * not have been updated which could create an infinite loo=
p below when
                 * waiting for the metadata cache to be flushed.
                 */

But as we unlock metadata_cache and lock it again in the consumer_metadata_=
cache_flushed(), I guess there is a window here when other things could get=
 time todo stuff not thought of.

Best regards,
Per=

--_002_B7B4BB465792624BAF51F33077E9906578D0D874ALAMBAcorpadwrs_
Content-Type: application/x-shellscript; name="lttng-hammer1.sh"
Content-Description: lttng-hammer1.sh
Content-Disposition: attachment; filename="lttng-hammer1.sh"; size=350;
	creation-date="Wed, 09 Sep 2015 11:52:27 GMT";
	modification-date="Wed, 09 Sep 2015 11:52:27 GMT"
Content-Transfer-Encoding: base64

IyEvYmluL3NoCgpjb3VudGVyPTAKCndoaWxlIHRydWU7IGRvCgllY2hvICJSb3VuZCAkY291bnRl
ciIKCWx0dG5nIGNyZWF0ZSBzMSAtLWxpdmUgLVUgbmV0Oi8vMTI4LjIyNC45NS4xOTk6NTMwMDA6
NTMwMDEKCWx0dG5nIGVuYWJsZS1jaGFubmVsIC1zIHMxIC11IG1ldGFkYXRhCglsdHRuZyBlbmFi
bGUtY2hhbm5lbCAtcyBzMSAtdSBjMQoJbHR0bmcgZW5hYmxlLWV2ZW50IC1zIHMxIC1jIGMxIC11
IC1hCglsdHRuZyBzdGFydCBzMQoKCS4vbHR0bmctdXN0LWV4YW1wbGUtMzIgJgoKCXdhaXQgJCEK
CglsdHRuZyBzdG9wIHMxCglsdHRuZyBkZXN0cm95IHMxCgkKCWNvdW50ZXI9JCgoY291bnRlcisx
KSkKZG9uZQo=

--_002_B7B4BB465792624BAF51F33077E9906578D0D874ALAMBAcorpadwrs_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--_002_B7B4BB465792624BAF51F33077E9906578D0D874ALAMBAcorpadwrs_--
