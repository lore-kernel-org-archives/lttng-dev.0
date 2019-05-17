From: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Subject: Re: lttng-tools-2.10.6: Spawning consumerd failed
Date: Fri, 17 May 2019 15:48:26 -0400
Message-ID: <20190517194826.GC9052__25412.6337634929$1558122529$gmane$org@joraj-alpa>
References: <CABRndgyrxUfZqtcu=4Y7U8rvjpBa=0AqcDCkvU3UMxixRfQCoQ@mail.gmail.com>
 <20190514142948.GA10361@joraj-alpa>
 <20190514180433.GB10361@joraj-alpa>
 <CABRndgxNtLbXZ0peWNm7qq_kxT4fY_PspgJ6hR=H82r3o8Nhmw@mail.gmail.com>
 <20190515143300.GA15967@joraj-alpa>
 <CABRndgwxboyBQ_5pSXEV+S2687=9rUsPEtww29qAxAHEnSOMfw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 455JkT4T7Lz11BK
 for <lttng-dev@lists.lttng.org>; Fri, 17 May 2019 15:48:33 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id E6DE01E59F9
 for <lttng-dev@lists.lttng.org>; Fri, 17 May 2019 15:48:26 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <CABRndgwxboyBQ_5pSXEV+S2687=9rUsPEtww29qAxAHEnSOMfw@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Zvi Vered <veredz72@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi,

You forgot to cc the mailing list. Adding it.

On Fri, May 17, 2019 at 04:50:02AM +0300, Zvi Vered wrote:
> Hi Janathan, All,
> 
> I solved the path issue with
> 
> export LTTNG_CONSUMERD32_BIN=/lib/lttng/libexec
> export LTTNG_CONSUMERD32_LIBDIR =/lib
> export LTTNG_SESSION_CONFIG_XSD_PATH=/share/lttng/...

This is a way to solve it, I would still recommend you fix it at the source
(proper cross build).

...

> ....
> DEBUG3 - 00:13:48.436226116 [1980/1980]: Looking for a kernel consumer at
> these locations: (in spawn_consumerd() at main.c:2429)
> DEBUG3 - 00:13:48.436252139 [1980/1980]:        1) NULL (in
> spawn_consumerd() at main.c:2430)
> DEBUG3 - 00:13:48.436256414 [1980/1980]:        2)
> /64_sw/git/zvi_vered/MY_PROJ/linux4.9.20/boot/rootfs/lib/lttng/libexec/lttng-consumerd
> (in spawn_consumerd() at main.c:2431)
> DEBUG3 - 00:13:48.436260543 [1980/1980]:        3) /lib/lttng/libexec (in
> spawn_consumerd() at main.c:2432)
> DEBUG3 - 00:13:48.436313492 [1980/1980]: Found location #3 (in
> spawn_consumerd() at main.c:2441)
> DEBUG1 - 00:13:48.436319027 [1980/1980]: Using kernel consumer at:
> /lib/lttng/libexec (in spawn_consumerd() at main.c:2448)
> PERROR - 00:13:48.436341261 [1980/1980]: Consumer execl(): Permission
> denied (in spawn_consumerd() at main.c:2539)

We found the consumerd in /lib/lttng/libexec/lttng-consumerd. Good.

We now try to execl the following:

/lib/lttng/libexec/lttng-consumerd -k --consumerd-cmd-sock <a_path> --consumerd-error-sock <b_path> --group root

And execl returns "Permission Denied".

Clearly, /lib/lttng/libexec/lttng-consumerd have some permissions problem.

"Permission denied" is linked to EACCES on my system.
  asm-generic/errno-base.h
  17:#define    EACCES          13     /* Permission denied */

"man execve" list all the reasons why execl might return EACCES per "man execl":

  EACCES Search permission is denied on a component of the path prefix of filename or the name of a script interpreter.  (See also path_resolution(7).)
  EACCES The file or a script interpreter is not a regular file.
  EACCES Execute permission is denied for the file or a script or ELF interpreter.
  EACCES The filesystem is mounted noexec.

One of them probably fit your current scenario.

Let us know how it goes.

Cheers

-- 
Jonathan Rajotte-Julien
EfficiOS
