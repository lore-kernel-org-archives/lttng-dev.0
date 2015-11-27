From: Samuel Martin <s.martin49@gmail.com>
Subject: Re: [PATCH lttng-tools] configure.ac: fix static build
Date: Fri, 27 Nov 2015 22:20:33 +0100
Message-ID: <CAHXCMMK10==xWormWDQ972=XoymwdCzGZaouRct88nh6nVbABg__7571.28039044819$1448659337$gmane$org@mail.gmail.com>
References: <1448231881-7988-1-git-send-email-s.martin49@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <s.martin49@gmail.com>) id 1a2QSE-0003tg-Ow
 for lttng-dev@lists.lttng.org; Fri, 27 Nov 2015 16:21:21 -0500
Received: by pabfh17 with SMTP id fh17so127002092pab.0
 for <lttng-dev@lists.lttng.org>; Fri, 27 Nov 2015 13:21:13 -0800 (PST)
In-Reply-To: <1448231881-7988-1-git-send-email-s.martin49@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi all,

On Sun, Nov 22, 2015 at 11:38 PM, Samuel Martin <s.martin49@gmail.com> wrote:
> For static build, some extra LDFLAGS may be needed.
>
> Using PKG_CHECK_MODULES instead of AC_CHECK_LIB for librairy detection
> allows to get all these flags. Then, the LIBS variable can be extended
> with everything that is needed.
>
> So, use PKG_CHECK_MODULES for popt and uuid detection; which both depend
> on libintl.
>
> This changes fixes build failures triggered with Buildroot, e.g.:
>   http://autobuild.buildroot.net/results/0f1/0f1e015a0c5a5ac2beeb5011d31a1e0058a32a0d/build-end.log

For the record, I just file a bug report about it:
https://bugs.lttng.org/issues/979

Cheers,
