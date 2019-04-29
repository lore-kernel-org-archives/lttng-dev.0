From: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Subject: Re: running lttng 2.10 on Docker 1.13.1
Date: Mon, 29 Apr 2019 11:11:16 -0400
Message-ID: <20190429151116.GB31289__26098.9098272816$1556550798$gmane$org@joraj-alpa>
References: <97612750.1097694.1556328978552.ref@mail.yahoo.com>
 <97612750.1097694.1556328978552@mail.yahoo.com>
 <925094052.1088921.1556329487899@mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 44t7Qz5M0Lz1L19
 for <lttng-dev@lists.lttng.org>; Mon, 29 Apr 2019 11:11:23 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <925094052.1088921.1556329487899@mail.yahoo.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: "whalajam@yahoo.com" <whalajam@yahoo.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi John,

On Sat, Apr 27, 2019 at 01:44:47AM +0000, whalajam--- via lttng-dev wrote:
>  I attach the lttng-sessiond -vvv output,John
>     On Friday, April 26, 2019, 9:38:36 p.m. EDT, whalajam--- via lttng-de=
v <lttng-dev@lists.lttng.org> wrote:  =

>  =

>  Hi,I have one docker container on which I installed LTTng version 2.10.I=
 use
>  the same Docker container to build and run the application.=A0The proble=
m I
>  have is that there are no traces in the path specified when doing "lttng
>  create". "lttng view"fails complaining about files not found, the trace
>  directories are sometimes added to the path but the
>  /root/lttng../../../channel0_* files are empty.=3DC2=3DA0I've followed t=
he
>  installation instructions from=3DC2=3DA0http://frederic-wou.net/lttng/an=
d docs
>  on=3DC2=3DA0https://lttng.org/docs/v2.10/=3DC2=3DA0These are the command=
s: "lttng
>  enable -u a:b", "lttng start", <excercise-the-tracepoints>,"lttng stop" =
and
>  "lttng view". lttng-consumerd is running. Running 'lttng-sessiond --vvv'
>  returns DEBUG info and an error about server already runningWhat could b=
e the
>  reason for the failure, how can I debug it?John

Multiple things going on here.

First, I gather from your explanation and log from sessiond that you most
probably installed lttng using a PPA or an equivalent. Note that some packa=
ges
will install a service and launch a root lttng-sessiond on start.

To get a verbose lttng-sessiond, you can disable this service, and then run
lttng-sessiond manually with the verbose option (-vvv --verbose-consumer).

   systemctl stop lttng-sessiond.serive
   systemctl disable lttng-sessiond.service
   lttng-sessiond -vvv --verbose-consumer

Or you can modify the service file. You will have to add the necessary opti=
ons
and systemd output redirection.

If this is not the case, make sure to kill the other instance of lttng-sess=
iond.

> DEBUG3 - 22:36:39.908815000 [23511/23511]: Creating LTTng run directory: =
/var/run/lttng (in create_lttng_rundir() at main.c:5301)
> Error: A session daemon is already running.

As for your actual "problem", the likely culprit is that either no instrume=
nted
application is tracing and no file are generated or you forgot to issue a "=
lttng
stop" or "lttng destroy" (on destroy an implicit stop is done since 2.9 if I
recall correctly) command.

When launching an app that you know is instrumented you can launch it with
LTTNG_UST_DEBUG=3Dy env variable defined to get more information e.g if the=
 app is
able to actually register to a lttng-sessiond instances.

Could you give us more information on the Docker image used
and if an open-source version of it is available so we can try and recreate=
 the
problem? I guess, most probably, a Centos image on the tutorial link you
provided. We would still need the version and as much information you can
provide.

Cheers
