From: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: FW: LTTNG-Tools-2.1.1 Support for PPC-32Bit/64bit;
 Unable to Resolve the Dependencies
Date: Mon, 22 Apr 2013 11:31:43 -0400
Message-ID: <CA+jJMxtJnOYLbXqLW9Cf51n0AwSJQfp0zHrzN0PSJ0GibHEfgA__33956.2789923095$1366644736$gmane$org@mail.gmail.com>
References: <A492A571B9D6304983C4106E4956338D04C3A87D@BLUPRD0811MB426.namprd08.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-we0-f176.google.com ([74.125.82.176])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1UUIib-00086D-C8
	for lttng-dev@lists.lttng.org; Mon, 22 Apr 2013 11:31:49 -0400
Received: by mail-we0-f176.google.com with SMTP id s10so1562416wey.21
	for <lttng-dev@lists.lttng.org>; Mon, 22 Apr 2013 08:31:43 -0700 (PDT)
In-Reply-To: <A492A571B9D6304983C4106E4956338D04C3A87D@BLUPRD0811MB426.namprd08.prod.outlook.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: SIDDHARTH VERMA <SIDDHARTH.VERMA@radisys.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On Mon, Apr 22, 2013 at 1:20 AM, SIDDHARTH VERMA
<SIDDHARTH.VERMA@radisys.com> wrote:
> Hi Lttng-Support,
>
>
>
> I used following commands to compile and install the LTTng on PPC Board::
>
>
>
> 1. ./configure --host=3Dpowerpc-linux CC=3D/usr/bin/ppc-linux-gcc CFLAGS=
=3D"-m32
> -g -O2"
>
> 2. make
>
> 3. make install
>
> 4. ldconfig
>
>
>
> ------------------------
>
> Error Logs for LTTng-Tools-2.1.1 && lttng-ust-2.2.0-rc1 &&
> userspace-rcu-0.7.2::
>
> ------------------------

Is there a reason you are using the stable 2.1 lttng-tools and the
2.2-rc release of lttng-ust? I'd recommend you use stable 2.1 releases
of both projects since they have been tested a lot more than the 2.2
release candidates.

>
> liburcu & lttng-ust installed but getting below error while trying to make
> LTTng-Tools
>
> ------------------------
>
> ------------------------
>
> [root@172.27.4.128]# make
>
> Making all in src
>
> make[1]: Entering directory `/root/siverma/2.1.1/lttng-tools-2.2.0-rc1/sr=
c'
>
> Making all in common
>
> make[2]: Entering directory
> `/root/siverma/2.1.1/lttng-tools-2.2.0-rc1/src/common'
>
> Making all in compat
>
> make[3]: Entering directory
> `/root/siverma/2.1.1/lttng-tools-2.2.0-rc1/src/common/compat'
>
>   CC     compat-fcntl.lo
>
>   CC     compat-epoll.lo
>
> In file included from compat-epoll.c:31:
>
> poll.h:72: error: 'EPOLLRDHUP' undeclared here (not in a function)
>
> poll.h:74: error: 'EPOLL_CLOEXEC' undeclared here (not in a function)
>
> compat-epoll.c: In function 'compat_epoll_create':
>
> compat-epoll.c:77: warning: implicit declaration of function 'epoll_creat=
e1'
>
> make[3]: *** [compat-epoll.lo] Error 1
>
> make[3]: Leaving directory
> `/root/siverma/2.1.1/lttng-tools-2.2.0-rc1/src/common/compat'
>
> make[2]: *** [all-recursive] Error 1
>
> make[2]: Leaving directory
> `/root/siverma/2.1.1/lttng-tools-2.2.0-rc1/src/common'
>
> make[1]: *** [all-recursive] Error 1
>
> make[1]: Leaving directory `/root/siverma/2.1.1/lttng-tools-2.2.0-rc1/src'
>
> make: *** [all-recursive] Error 1
>
>
>
> ------------------------------------
>
> I also tried with the previous version of the tool
>
> liburcu installed but getting below dependencies while trying to configure
> for lttng-ust
>
> ------------------------------------
>
>
>
> Error Logs lttng-ust-1.9.2 && lttng-tools-2.0.0-rc1 && userspace-rcu-0.6.6
> ::
>
> ------------------------------------
>
> ------------------------------------
>
> checking for GNU libc compatible malloc... yes
>
> checking for gettimeofday... yes
>
> checking for munmap... yes
>
> checking for socket... yes
>
> checking for strerror... yes
>
> checking for strtol... yes
>
> checking for makeinfo... no
>
> configure: error: Please install the 'texinfo' program and make sure
> 'makeinfo' is in the PATH.
>
>
>
> --------------------------------------------------------
>
> --------------------------------------------------------
>
>
>
> It seems there are many dependencies involved in the installation of the
> LTTng, some of them are as follows;
>
>
>
> Texinfo
>
> Makeinfo
>
> kernel image to 2.6.38 or higher
>
> librc
>
> libpotp > 1.13
>
> tcltk
>
> libasprintf
>
> gettext
>
> gc++
>
> glib 2.34.0 and some more packages.
>
>
>
> Do we have to download and cross compile them all for ppc or we can get s=
ome
> help from standard package managers for the same?

You'll have to cross-compile the dependencies for your target system.

>
> As of now the kernel used in machine is =933.4.3-rt13=94
>
>
>
> [root@172.27.4.128]# uname -a
>
> Linux 172.27.4.128 3.4.3-rt13 #1 SMP PREEMPT RT Sat Feb 23 09:46:06 CST 2=
013
> ppc ppc ppc GNU/Linux
>
>
>
> As per my observations it may take a lot of time to resolve them all as we
> have to decide all the correct supporting packages
>
> with the correct releases in order to make them work for a particular Lin=
ux
> image, though its easy to resolve it by using
>
> standard package managers in latest Linux e.g. UBUNTU.
>
>
>
> Please suggest on the same.
>

Christian Babeux submitted a guide to cross-compiling LTTng on
StackOverflow[1]. I'd suggest you have a look.
You will, however, have to install the cross-compiled dependencies to
your target root as your first step.

Regards,
J=E9r=E9mie

[1] http://stackoverflow.com/questions/13774455/how-do-i-build-and-deploy-l=
ttng-to-an-embedded-linux-system

>
>
> Regards
>
> Siddharth Verma
>
> Mobile: +91-9880621252
>
> siddharth.verma@radisys.com
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
