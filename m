From: Jesper Derehag <jderehag@hotmail.com>
Subject: Configurable tracepath?
Date: Wed, 25 Mar 2015 15:52:48 +0000
Message-ID: <DUB123-W464BA7F0C2F678C748C48EDD0B0__24653.4247221009$1427298838$gmane$org@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from dub004-omc3s1.hotmail.com ([157.55.2.10])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jderehag@hotmail.com>) id 1Yanby-00065G-B4
 for lttng-dev@lists.lttng.org; Wed, 25 Mar 2015 11:53:01 -0400
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

Hi,

We have run into an issue with unique per-session tracepaths.=A0

In my particular setup I am using relayd to centralize alot of consumers (n=
ot really important to this discussion, but thought I'd mention it anyway).
So the problem is that=A0I have very limited quota for %outputpath. So to m=
anage the quota fairly between channels I am using=A0--tracefile-size to li=
mit the size of each channel and thus preventing them from starving eachoth=
er out.
BUT, say I would want to restart the session for some reason, in my case it=
 might be that the card running a specific session reboots, and then relayd=
 would get a new session & channel, and thus create a new folder for that d=
ata. But since the old data still remains, I would run into the quota limit=
..=A0

Below is how the tracepaths are created in pseudo-code:

per-pid tracing:
=A0 =A0tracepath =3D %outputpath/%pid/%session_name-%pid-%datetime

per-uid tracing:
=A0 =A0tracepath =3D %outputpath/uid/%uid/%arch-bit

So just reading this little snippet I am guessing one could avoid this part=
icular problem by doing per-uid tracing, but that seems like an unnecessary=
 workaround for what would seem like a trivial problem?

Would it instead be feasable to have the channel->path_name configurable, s=
o that you essentially could avoid the uniqueness of the path (pid & dateti=
me)?

Or is that instead opening pandoras box w.r.t. to tracefile consistency and=
 contention?

Regards,
Jesper 		 	   		  =
