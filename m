From: Philippe Proulx <eeppeliteloop@gmail.com>
Subject: Re: (no subject)
Date: Thu, 26 Nov 2015 23:28:58 -0500
Message-ID: <CAB4xu_3Vv=x1zkBayazqxi_dUSVVfWO5CW9-hSur3dGSoWes=Q__29917.032182175$1448598619$gmane$org@mail.gmail.com>
References: <CABRndgzjgufnXE7_0Erp=B2P-5j3w4nZFhShn8V5oqGxd8PPaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lf0-f53.google.com ([209.85.215.53])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <eeppeliteloop@gmail.com>) id 1a2Af7-00073O-Ee
 for lttng-dev@lists.lttng.org; Thu, 26 Nov 2015 23:29:35 -0500
Received: by lfaz4 with SMTP id z4so116040121lfa.0
 for <lttng-dev@lists.lttng.org>; Thu, 26 Nov 2015 20:29:27 -0800 (PST)
In-Reply-To: <CABRndgzjgufnXE7_0Erp=B2P-5j3w4nZFhShn8V5oqGxd8PPaw@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Zvi Vered <veredz72@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Isn't there a libuuid development package for CentOS 5
instead of building it from source?

Like this: <http://pkgs.org/centos-5/epel-i386/uuid-devel-1.5.1-3.el5.i386.rpm.html>?

Really not a CentOS/RPM expert here.

Philippe Proulx


On Thu, Nov 26, 2015 at 10:20 PM, Zvi Vered <veredz72@gmail.com> wrote:
> Hello,
>
> I downloaded lttng-tools-2.7.0 and tried to run ./configure.
>
> I got the error message:
>
> ....
> checking for xml2-config... /home/zvivered/GNU/libxml2/release/bin/xml2-config
> checking for libxml - version >= 2.7.6... yes (version 2.7.7)
> checking for uuid_generate in -luuid... no
> checking for uuid_create in -lc... no
> configure: error: Cannot find libuuid uuid_generate nor libc
> uuid_create. Use LDFLAGS=-Ldir to specify their location.
>
> I'm working with Centos 5.5 (32).
> I downloaded libuuid-1.0.3.tar.gz from http://sourceforge.net/projects/libuuid/
> It solved the .configure problem. Is this the right download place ?
>
> Best regards,
> Z.V
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
