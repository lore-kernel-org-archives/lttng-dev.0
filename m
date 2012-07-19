From: "Woegerer, Paul" <Paul_Woegerer@mentor.com>
Subject: Re: LTTng-UST alternative to LD_PRELOAD
Date: Thu, 19 Jul 2012 09:26:54 +0200
Message-ID: <5007B6BE.4020209__38309.3609045774$1342682815$gmane$org@mentor.com>
References: <1339945703.2599.21.camel@DellE5500>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Paul_Woegerer@mentor.com>) id 1Srl7x-00010f-Ub
	for lttng-dev@lists.lttng.org; Thu, 19 Jul 2012 03:26:26 -0400
Received: from svr-orw-fem-01.mgc.mentorg.com ([147.34.98.93])
	by relay1.mentorg.com with esmtp
	id 1Srl7r-0005X1-9t from Paul_Woegerer@mentor.com
	for lttng-dev@lists.lttng.org; Thu, 19 Jul 2012 00:26:19 -0700
In-Reply-To: <1339945703.2599.21.camel@DellE5500>
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

On 06/17/2012 05:08 PM, Lars wrote:
> Hello,
>
> I have recently started to use LTTng-UST and am using LD_PRELOAD
> to make it possilbe to execute instrumented code on systems without
> LTTng-UST installed.
>
> To define LD_PRELOAD however affects too much. For instance all
> forked processes also get the library loaded. This can be fixed by
> removing the library from the LD_PRELOAD variable early in the main
> function. This looks odd and required some explaining in comments.
>
> Also, in my case, the instrumented program is started with a "wrapper"
> program which I can not alter. This wrapper also gets the library
> loaded.
>
> As an alternative to using LD_PRELOAD I would like to use an explicit
> function, like;
>
>    int traceload(char const* library_path);
>
> that is called early in main (instead of the LD_PRELOAD environment
> manipulation) and loads the library with dlopen if it exists.
>
> I have already tried this (of course) and it almost works already.
> The tracepoints becomes visible but I get no trace data written.
> So I think a really small modification is needed.

Another alternative would be to implement an lttng-backend for latrace ( =

see: http://people.redhat.com/jolsa/latrace/index.shtml ).

Library calls from the following headers are supported as of version =

0.5.11:

ctype.h   dlfcn.h  getopt.h  ioctl.h    libintl.h  locale.h  mman.h netdb.h=
   pwd.h    signal.h  stat.h     stdlib.h   sysdeps   term.h time.h    unis=
td.h wait.h    dirent.h   fcntl.h    inet.h    latrace.h libio.h   misc.h  =
 ncurses.h pthread.h  resource.h socket.h  stdio.h string.h  syslog.h termi=
os.h typedefs.h utmp.h

So if we let latrace optionally emit lttng events for call enter and exit w=
e would instantly get support for tracing for _any_ library call.

--
Paul

-- =

Paul Woegerer | SW Development Engineer
Mentor Embedded(tm) | Prinz Eugen Stra=DFe 72/2/4, Vienna, 1040 Austria
P 43.1.535991320
Nucleus=AE | Linux=AE | Android(tm) | Services | UI | Multi-OS

Android is a trademark of Google Inc. Use of this trademark is subject to G=
oogle Permissions.
Linux is the registered trademark of Linus Torvalds in the U.S. and other c=
ountries.
