From: Francis Giraldeau <francis.giraldeau@gmail.com>
Subject: Re: Userspace Tracing
Date: Sun, 15 Dec 2013 17:36:58 -0500
Message-ID: <52AE2F0A.7000400__11377.8428444222$1387148108$gmane$org@gmail.com>
References: <CAN7pGtv367co+mh3-m8+=W437+_rQk8oUoqpK_sE_MrGFxMLxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qc0-f177.google.com ([209.85.216.177])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <francis.giraldeau@gmail.com>) id 1VsKZn-0006lx-IP
	for lttng-dev@lists.lttng.org; Sun, 15 Dec 2013 17:54:21 -0500
Received: by mail-qc0-f177.google.com with SMTP id m20so3117974qcx.22
	for <lttng-dev@lists.lttng.org>; Sun, 15 Dec 2013 14:54:14 -0800 (PST)
In-Reply-To: <CAN7pGtv367co+mh3-m8+=W437+_rQk8oUoqpK_sE_MrGFxMLxA@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Michael Steppe <msteppe91@gmail.com>, "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Le 2013-12-13 14:53, Michael Steppe a =E9crit :
> Hello!
> =

> I have a question regarding userspace tracing. I am working on a project
> on which we have used LTTng in the past (prior to LTTng 2.0). In order
> to see how our application was running in coordination with the kernel,
> we created a .h file in which we would append strings to
> "/mnt/debugfs/ltt/write_event" in order to see our application timing in
> the LTTng viewer in Eclipse.
> =

> Since then we have updated to LTTng 2.0.4. It would be very hard for us
> to change to a different version at the current time. I have noticed
> that /mnt/debugfs/ltt/write_event no longer exists in 2.0.4 and was
> wondering (crossing my fingers) that this location has simply changed or
> is there a new filesystem that you use?

This feature has not been included in lttng 2. I think that this feature
is useful, and I tried last year to bring it back. It was close to be
merged as a separate proc file, but someone pointed that it would be
better to profile the file with debugfs. I haven't work on it since
then. I may give it another spin later, but I can't right now.

http://lists.lttng.org/pipermail/lttng-dev/2012-July/018210.html

Cheers,

Francis
