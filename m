From: Michael Steppe <msteppe91@gmail.com>
Subject: Userspace Tracing
Date: Fri, 13 Dec 2013 14:53:28 -0500
Message-ID: <CAN7pGtv367co+mh3-m8+=W437+_rQk8oUoqpK_sE_MrGFxMLxA__28687.2092904106$1386964485$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1438703029=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qa0-f45.google.com ([209.85.216.45])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <msteppe91@gmail.com>) id 1VrYnm-0000PB-AH
	for lttng-dev@lists.lttng.org; Fri, 13 Dec 2013 14:53:39 -0500
Received: by mail-qa0-f45.google.com with SMTP id o15so1103216qap.18
	for <lttng-dev@lists.lttng.org>; Fri, 13 Dec 2013 11:53:28 -0800 (PST)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============1438703029==
Content-Type: multipart/alternative; boundary=001a11c2be5ae6836104ed6fd0da

--001a11c2be5ae6836104ed6fd0da
Content-Type: text/plain; charset=ISO-8859-1

Hello!

I have a question regarding userspace tracing. I am working on a project on
which we have used LTTng in the past (prior to LTTng 2.0). In order to see
how our application was running in coordination with the kernel, we created
a .h file in which we would append strings to
"/mnt/debugfs/ltt/write_event" in order to see our application timing in
the LTTng viewer in Eclipse.

Since then we have updated to LTTng 2.0.4. It would be very hard for us to
change to a different version at the current time. I have noticed that
/mnt/debugfs/ltt/write_event no longer exists in 2.0.4 and was wondering
(crossing my fingers) that this location has simply changed or is there a
new filesystem that you use?

Thanks!!
Michael Steppe

--001a11c2be5ae6836104ed6fd0da
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div>Hello!<br><br></div>I have a question regar=
ding userspace tracing. I am working on a project on which we have used LTT=
ng in the past (prior to LTTng 2.0). In order to see how our application wa=
s running in coordination with the kernel, we created a .h file in which we=
 would append strings to &quot;/mnt/debugfs/ltt/write_event&quot; in order =
to see our application timing in the LTTng viewer in Eclipse.<br>
<br>Since then we have updated to LTTng 2.0.4. It would be very hard for us=
 to change to a different version at the current time. I have noticed that =
/mnt/debugfs/ltt/write_event no longer exists in 2.0.4 and was wondering (c=
rossing my fingers) that this location has simply changed or is there a new=
 filesystem that you use?<br>
<br></div>Thanks!!<br></div>Michael Steppe<br></div>

--001a11c2be5ae6836104ed6fd0da--


--===============1438703029==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1438703029==--
