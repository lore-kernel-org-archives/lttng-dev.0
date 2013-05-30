From: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: using a custom channel
Date: Thu, 30 May 2013 13:44:39 -0400
Message-ID: <CA+jJMxtMxym3w+4KGPbHoLoEhM-GTuP3sCy-3uF07xiQBBsdfg__27227.5558593266$1369936888$gmane$org@mail.gmail.com>
References: <51A4A3B9.7010303@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wg0-f49.google.com ([74.125.82.49])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1Ui73l-0005Vq-4U
	for lttng-dev@lists.lttng.org; Thu, 30 May 2013 13:55:06 -0400
Received: by mail-wg0-f49.google.com with SMTP id y10so500215wgg.4
	for <lttng-dev@lists.lttng.org>; Thu, 30 May 2013 10:54:39 -0700 (PDT)
In-Reply-To: <51A4A3B9.7010303@free.fr>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?ISO-8859-1?Q?St=E9phane_ANCELOT?= <sancelot@free.fr>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi,

You have to create a new channel using

lttng --enable-channel MyNewChannel -k

and then enable the events you wish to collect in this channel.

lttng enable-event -k -a --channel MyNewChannel

Hopefully this answers your question,
J=E9r=E9mie

On Tue, May 28, 2013 at 8:31 AM, St=E9phane ANCELOT <sancelot@free.fr> wrot=
e:
> Hi,
>
> I finally managed to create my trace events probes...
> I copied my .h header in instrumentation/event/lttng-module and create a
> lttng probe module
>
> but now, I would like to use other channels than channel0 , how to do thi=
s,
> I tried using xn_nucleus_blahblah as event name, but it has not helped , =
it
> is seen in channel0
>
> Regards,
> Steph
>
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev



-- =

J=E9r=E9mie Galarneau
EfficiOS Inc.
http://www.efficios.com
