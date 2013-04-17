From: Simon Marchi <simon.marchi@polymtl.ca>
Subject: Re: LTTNG UST configure error (lttng-ust-2.1.2)
Date: Wed, 17 Apr 2013 13:50:52 -0400
Message-ID: <CAFXXi0m4yL4YQ-LKyKhyzMrryL7vgxm5HWWSWYRvNO_d+=2LNA__666.897980454628$1366221110$gmane$org@mail.gmail.com>
References: <05E83BDD0E1F054FA73F00F6970F05C60618B3@CH1PRD0810MB394.namprd08.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <thundersim@gmail.com>) id 1USWW0-0002L1-0e
	for lttng-dev@lists.lttng.org; Wed, 17 Apr 2013 13:51:28 -0400
Received: by mail-ie0-f175.google.com with SMTP id a11so951717iee.34
	for <lttng-dev@lists.lttng.org>; Wed, 17 Apr 2013 10:51:22 -0700 (PDT)
In-Reply-To: <05E83BDD0E1F054FA73F00F6970F05C60618B3@CH1PRD0810MB394.namprd08.prod.outlook.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Hari Prasad Kalavakunta <Hari.Prasad@radisys.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi Hari,

libuuid is indeed required in order to build LTTng-UST for every
platform. The usual way to install it is through a package manager
(package uuid-dev on debian/ubuntu, for example). If this is not an
option, you will have to build it from source. It is part of the
util-linux package [1][2]. util-linux contains a lot of tools though,
try to see if you can only build and install libuuid from it.

Simon

[1] http://git.kernel.org/cgit/utils/util-linux/util-linux.git
[2] ftp://ftp.kernel.org/pub/linux/utils/util-linux/

On 17 April 2013 13:28, Hari Prasad Kalavakunta <Hari.Prasad@radisys.com> wrote:
> Hi lttng-dev,
>
>
>
> I am struck with the following road block. Could you please help me.
>
>
>
> While cross-compiling  LTTNG UST for ppc32 I choose
> --disable-libtool-linkdep-fixup (https://bugs.lttng.org/issues/321) for
> configure to avoid dependency on libuuid as shown below.
>
>
>
> CFLAGS="-m32 -g -O2" ./configure --disable-libtool-linkdep-fixup
> --prefix=/home/xxx/linux-3.4.3/ --host=powerpc-linux
> --with-sysroot=/home/xxx/linux-3.4.3/
>
>
>
> Yet, the dependencies are not completely removed. I am cross compiling LTTNG
> UST for PPC32. It did not look like I need libuuid. Could you please let me
> know how to overcome it. Or do I need libuuid for PPC32?
>
>
>
> I have successfully cross compiled and installed userspace-rcu for ppc32.
>
>
>
> Please let me know if I need to provide any additional details.
>
>
>
> Regards,
>
> Hari
>
>
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
