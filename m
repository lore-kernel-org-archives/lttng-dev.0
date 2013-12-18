From: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: lttng with syslog and stdout
Date: Wed, 18 Dec 2013 10:04:38 -0500
Message-ID: <CA+jJMxu+bmJk+mAHzWXx6bySxKTG5XWbNJLh3sRo30MiYCxbzw__44368.2740828537$1387380771$gmane$org@mail.gmail.com>
References: <CAM5kDqzmGS7w7B6-KdvP_wEafJ626omhJQ5RC7Q8sV4-RU5riQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qc0-f173.google.com ([209.85.216.173])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1VtIfz-0003kR-P3
	for lttng-dev@lists.lttng.org; Wed, 18 Dec 2013 10:04:49 -0500
Received: by mail-qc0-f173.google.com with SMTP id m20so6325131qcx.32
	for <lttng-dev@lists.lttng.org>; Wed, 18 Dec 2013 07:04:38 -0800 (PST)
In-Reply-To: <CAM5kDqzmGS7w7B6-KdvP_wEafJ626omhJQ5RC7Q8sV4-RU5riQ@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Anand Neeli <anand.neeli@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On Wed, Dec 18, 2013 at 5:51 AM, Anand Neeli <anand.neeli@gmail.com> wrote:
> Hi All,
> Here are some queries i have. Can someone please help me with them.
>
> 1) is there a way send selective traces from lttng to syslog; and should =
be
> configurable based on the priority. (say like i want to send all CRIT or
> EMRG traces to syslog)
>

Not directly. You could probably work something out by parsing the
output of babeltrace in "live" mode. Look at the --log-level option of
the lttng enable-event command in the lttng(1) man page to only record
events of certain log levels.

Be aware that LTTng can drop events under heavy loads; make sure that
is not a problem in your particular scenario.

> 2) is there a way to stdout the logs of lttng. (similar to above this sho=
uld
> also be configurable based on the priority)
>

The live tracing mode, introduced in LTTng 2.4, seems to fit your
use-case with the aforementioned event-drop caveat.

Regards,
J=E9r=E9mie

> What i'm trying here is to use syslog for critical messages and use stdout
> when debugging live.
>
> Please give me pointers if this is already there.
>
> Thanks in advance.
> Anand Neeli
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>



-- =

J=E9r=E9mie Galarneau
EfficiOS Inc.
http://www.efficios.com
