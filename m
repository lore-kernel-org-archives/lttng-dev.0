From: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Subject: Re: lttng-tools-2.10.6: Spawning consumerd failed
Date: Wed, 15 May 2019 10:33:00 -0400
Message-ID: <20190515143300.GA15967__6602.61180471338$1557930803$gmane$org@joraj-alpa>
References: <CABRndgyrxUfZqtcu=4Y7U8rvjpBa=0AqcDCkvU3UMxixRfQCoQ@mail.gmail.com>
 <20190514142948.GA10361@joraj-alpa>
 <20190514180433.GB10361@joraj-alpa>
 <CABRndgxNtLbXZ0peWNm7qq_kxT4fY_PspgJ6hR=H82r3o8Nhmw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 453xqR497bz11bw
 for <lttng-dev@lists.lttng.org>; Wed, 15 May 2019 10:33:07 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 2AEECBD58A
 for <lttng-dev@lists.lttng.org>; Wed, 15 May 2019 10:33:05 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <CABRndgxNtLbXZ0peWNm7qq_kxT4fY_PspgJ6hR=H82r3o8Nhmw@mail.gmail.com>
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

On Wed, May 15, 2019 at 04:42:57PM +0300, Zvi Vered wrote:
> Hi Jonathan,
> 
> I'm not using buildroot nor Yokto.
> In order to build lttng-tools I ran:
> ./configure --prefix=/64_sw/git/zvi_vered/MY_PROJ/linux4.9.20/boot/rootfs

I'm no expert on building/cross compiling but I think you are missing some
options here. with-sysroot is probably one of them.

I think this should do the trick:

./configure --with-sysroot=/64_sw/git/zvi_vered/MY_PROJ/linux4.9.20/boot/rootfs
--prefix /

Another possibility would be using DESTDIR on make install.

> make
> make install
> 
> This path contains a complete root file system (based on busybox) that is
> later copied to my target.
> 
> On the target I ran:
> lttng-sessiond -vvv --verbose-consumer
> and got:
> ....
> I/O warning : failed to load external entity
> "/64_sw/git/zvi_vered/MY_PROJ/linux4.9.20/boot/rootfs/share/xml/lttng/session.xsd"
> XML Error: Failed to locate the main schema resource at
> '/64_sw/git/zvi_vered/MY_PROJ/linux4.9.20/boot/rootfs/share/xml/lttng/session.xsd'.
> Error: XSD parsing failed
> Error: Session load failed: Invalid session configuration
> DEBUG1 - 00:10:36.746330272 [1476/1618]: Accepting client command ... (in
> thread_manage_clients() at main.c:4374)
> 
> Then I ran:
> lttng create my-kernel-session
> and got:
> ....
> DEBUG3 - 00:11:41.869875832 [1628/1628]: Looking for a kernel consumer at
> these locations: (in spawn_consumerd() at main.c:2429)
> DEBUG3 - 00:11:41.869901726 [1628/1628]:        1) NULL (in
> spawn_consumerd() at main.c:2430)
> DEBUG3 - 00:11:41.869908520 [1628/1628]:        2)
> /64_sw/git/zvi_vered/MY_PROJ/linux4.9.20/boot/rootfs/lib/lttng/libexec/lttng-consumerd
> (in spawn_consumerd() at main.c:2431)
> DEBUG3 - 00:11:41.869915959 [1628/1628]:        3)
> /64_sw/git/zvi_vered/MY_PROJ/linux4.9.20/boot/rootfs/lib/lttng/libexec/lttng-consumerd
> (in spawn_consumerd() at main.c:2432)
> DEBUG1 - 00:11:41.869971468 [1628/1628]: Could not find any valid consumerd
> executable (in spawn_consumerd() at main.c:2444)
> Error: Spawning consumerd failed
> 
> I double checked: The target has /lib/lttng-libexec/lttng-consumerd
> But it looks for it in:
>  /64_sw/git/zvi_vered/MY_PROJ/linux4.9.20/boot/rootfs/lib/lttng/libexec ]
> 
> What is missing in my configuration ?

The prefix is used to bake in the path used by lttng-sessiond for
consumerd lookup.

We use libdir as the base path.

  --libdir=DIR            object code libraries [EPREFIX/lib]

Cheers

-- 
Jonathan Rajotte-Julien
EfficiOS
