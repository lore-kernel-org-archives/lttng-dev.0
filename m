From: Simon Marchi <simon.marchi@polymtl.ca>
Subject: Re: (no subject)
Date: Thu, 14 May 2015 17:14:51 -0400
Message-ID: <CAFXXi0kf0aWS7vS9m8HmdPoXR3RL=bjtaL_y+coR7T2npE=eWQ__21421.8151908883$1431638212$gmane$org@mail.gmail.com>
References: <CAG4vvd49JfNUgN9p9vW0bQXoRkBjER74zVbTAg-CmtETZeDn2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ig0-f178.google.com ([209.85.213.178])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <thundersim@gmail.com>) id 1Yt0TX-0000vo-Qh
 for lttng-dev@lists.lttng.org; Thu, 14 May 2015 17:15:36 -0400
Received: by igbsb11 with SMTP id sb11so84288699igb.0
 for <lttng-dev@lists.lttng.org>; Thu, 14 May 2015 14:15:22 -0700 (PDT)
In-Reply-To: <CAG4vvd49JfNUgN9p9vW0bQXoRkBjER74zVbTAg-CmtETZeDn2Q@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Francis Rivest <francis.rivest13@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Ah, this is because we need to add abi-debian-version.sh to the Ubuntu
package. I don't have time to do it right away, but perhaps Alexandre
(in CC) does :).

On 14 May 2015 at 15:33, Francis Rivest <francis.rivest13@gmail.com> wrote:
> Hello again,
>
> We tried to install the lttng-modules-dkms package using apt and the
> "ppa:lttng/ppa" repository, but we get the following information and error:
>
> Unpacking lttng-modules-dkms (from .../lttng-modules-dkms_2.6.x+
> stable+bzr727+pack22+201504291801~ubuntu12.04.1_all.deb) ...
> Setting up lttng-modules-dkms
> (2.6.x+stable+bzr727+pack22+201504291801~ubuntu12.04.1)
> ...
> Loading new
> lttng-modules-2.6.x+stable+bzr727+pack22+201504291801~ubuntu12.04.1
> DKMS files...
> First Installation: checking all kernels...
> Building only for 3.13.0-32-generic
> Building initial module for 3.13.0-32-generic
> Error! Bad return status for module build on kernel: 3.13.0-32-generic
> (x86_64)
> Consult /var/lib/dkms/lttng-modules/2.6.x+stable+bzr727+pack22+
> 201504291801~ubuntu12.04.1/build/make.log for more information.
>
>
> The contain of the make.log file is the following:
>
> DKMS make.log for
> lttng-modules-2.6.x+stable+bzr727+pack22+201504291801~ubuntu12.04.1
> for kernel 3.13.0-32-generic (x86_64)
> Thu May 14 15:00:16 EDT 2015
> make: Entering directory `/usr/src/linux-headers-3.13.0-32-generic'
> /bin/sh: 1: /var/lib/dkms/lttng-modules/2.6.x+stable+bzr727+pack22+
> 201504291801~ubuntu12.04.1/build/abi-debian-version.sh: not found
> /bin/sh: 1: /var/lib/dkms/lttng-modules/2.6.x+stable+bzr727+pack22+
> 201504291801~ubuntu12.04.1/build/abi-debian-version.sh: not found
>    CC [M]  /var/lib/dkms/lttng-modules/2.6.x+stable+bzr727+pack22+
> 201504291801~ubuntu12.04.1/build/lttng-ring-buffer-client-discard.o
>    CC [M]  /var/lib/dkms/lttng-modules/2.6.x+stable+bzr727+pack22+
> 201504291801~ubuntu12.04.1/build/lttng-ring-buffer-client-overwrite.o
>    CC [M]  /var/lib/dkms/lttng-modules/2.6.x+stable+bzr727+pack22+
> 201504291801~ubuntu12.04.1/build/lttng-ring-buffer-metadata-client.o
>    CC [M]  /var/lib/dkms/lttng-modules/2.6.x+stable+bzr727+pack22+
> 201504291801~ubuntu12.04.1/build/lttng-ring-buffer-client-mmap-discard.o
>    CC [M]  /var/lib/dkms/lttng-modules/2.6.x+stable+bzr727+pack22+
> 201504291801~ubuntu12.04.1/build/lttng-ring-buffer-client-mmap-overwrite.o
>    CC [M]  /var/lib/dkms/lttng-modules/2.6.x+stable+bzr727+pack22+
> 201504291801~ubuntu12.04.1/build/lttng-ring-buffer-metadata-mmap-client.o
>    CC [M]  /var/lib/dkms/lttng-modules/2.6.x+stable+bzr727+pack22+
> 201504291801~ubuntu12.04.1/build/lttng-statedump-impl.o
>    CC [M]  /var/lib/dkms/lttng-modules/2.6.x+stable+bzr727+pack22+
> 201504291801~ubuntu12.04.1/build/wrapper/irqdesc.o
>    CC [M]  /var/lib/dkms/lttng-modules/2.6.x+stable+bzr727+pack22+
> 201504291801~ubuntu12.04.1/build/wrapper/fdtable.o
>    CC [M]  /var/lib/dkms/lttng-modules/2.6.x+stable+bzr727+pack22+
> 201504291801~ubuntu12.04.1/build/lttng-events.o
> In file included from /var/lib/dkms/lttng-modules/2.
> 6.x+stable+bzr727+pack22+201504291801~ubuntu12.04.1/
> build/lttng-events.c:27:0:
> /var/lib/dkms/lttng-modules/2.6.x+stable+bzr727+pack22+
> 201504291801~ubuntu12.04.1/build/wrapper/page_alloc.h:36:58: error:
> operator '+' has no right operand
> make[1]: *** [/var/lib/dkms/lttng-modules/2.6.x+stable+bzr727+pack22+
> 201504291801~ubuntu12.04.1/build/lttng-events.o] Error 1
> make: *** [_module_/var/lib/dkms/lttng-modules/2.6.x+stable+bzr727+
> pack22+201504291801~ubuntu12.04.1/build] Error 2
> make: Leaving directory `/usr/src/linux-headers-3.13.0-32-generic'
>
>
> We know that "abi-debian-version.sh" isn't found and that might be the
> cause of our problem but it is supposed to be in the package...
>
> In addition we tried to include manually this file but it didn't work.
>
> Thanks again for helping me out.
>
> -Francis R
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
