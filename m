From: Gerlando Falauto <gerlando.falauto@keymile.com>
Subject: Re: [PATCH lttng-ust] Fix: Corrected python version
 assumptions in lttng-gen-tp
Date: Tue, 13 May 2014 10:38:29 +0200
Message-ID: <5371DA05.60005__24466.0910372206$1399970376$gmane$org@keymile.com>
References: <1395671384-24750-1-git-send-email-jderehag@hotmail.com>,
 <654526496.119.1395756962956.JavaMail.zimbra@efficios.com>
 <DUB123-W18FF6C4DAEAEC5A2346C92DD650@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-de.keymile.com ([195.8.104.250])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <prvs=0210a591ee=gerlando.falauto@keymile.com>)
 id 1Wk8ER-000288-Ek
 for lttng-dev@lists.lttng.org; Tue, 13 May 2014 04:38:40 -0400
In-Reply-To: <DUB123-W18FF6C4DAEAEC5A2346C92DD650@phx.gbl>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jesper Derehag <jderehag@hotmail.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi Jesper,

[...]
 > I *thought* I was running on python2.7 but as it turns out I was not.
> When resolving "python" I get python2.7 but when I check the explicit version laying at /usr/bin/python its actually a 2.4 version so no wonder it was failing.
>
> Checking the PEP for when "except XX as yy" was introduced points to that it was introduced in python 2.6 so entirely my mistake.
> Reran it now with the a 2.7 version and it works as intended.
>
> However, I still think you should run it through env as proposed in the patch and not use the explicit path to python.

I still have some issues, even with this change.
As a matter of fact, my default python installation would be a python2.6:

$ python

python
Python 2.6.6 (r266:84292, Jan 22 2014, 05:06:49)

I'm however cross-compiling, so I specify a sysroot and I explicitly set 
the python version in my configure script:

$ . /opt/eldk/eldk_init ppc_6xx # set the env for cross-compiling

$ python2.7
Python 2.7.3 (default, Aug  2 2013, 20:37:10)
[GCC 4.7.2] on linux2

$ which python2.7
/opt/eldk/powerpc/sysroots/i686-eldk-linux/usr/bin/python2.7

$ ac_cv_header_linux_perf_event_h=no PYTHON=python2.7 ./configure 
--target=powerpc-linux --host=powerpc-linux --build=i686-linux 
--with-libtool-sysroot=/opt/eldk/powerpc/sysroots/powerpc-linux 
--prefix=/usr

$ MAKEFLAGS= && DESTDIR=/opt/eldk/powerpc/sysroots/powerpc-linux make 
all install install-strip pkgconfigdir=/tmp pkgconfig_DATA=

This doesn't however help, as the script will call "python" from the 
current environment (thereby ignoring the PYTHON= value used by the 
configure script when checking for python version).

So perhaps a solution would be to change the configure script (or 
whatever it comes from by means of autoconfig/automake) so to create a 
"python" symlink in the working directory (to the version 
selected/detected) and then add it to the path (*).

I guess a quick-and-dirty alternative could be to change the makefile so 
to use the "PYTHON" environment variable to explictly set what 
interpreter to use -- but that would defeat the whole purpose of the 
shebang so I believe it's a very bad idea:

--- a/doc/examples/gen-tp/Makefile
+++ b/doc/examples/gen-tp/Makefile
@@ -46,7 +46,7 @@ sample.o: sample.c sample_tracepoint.h
         CFLAGS="$(CFLAGS) $(AM_CFLAGS)" \
         LDFLAGS="$(LDFLAGS) $(AM_LDFLAGS)" \
         CC="$(CC)" \
-       $(LTTNG_GEN_TP_PATH)lttng-gen-tp -o $@ $<
+       $(PYTHON) $(LTTNG_GEN_TP_PATH)lttng-gen-tp -o $@ $<

  # The following rule can be used to generate all files instead of 
having one
  # for each file type. Note that the sample.o has a dependency on the
@@ -55,10 +55,10 @@ sample.o: sample.c sample_tracepoint.h
  #      lttng-gen-tp $<

  %.h: %.tp
-       $(LTTNG_GEN_TP_PATH)lttng-gen-tp -o $@ $<
+       $(PYTHON) $(LTTNG_GEN_TP_PATH)lttng-gen-tp -o $@ $<

  %.c: %.tp
-       $(LTTNG_GEN_TP_PATH)lttng-gen-tp -o $@ $<
+       $(PYTHON) $(LTTNG_GEN_TP_PATH)lttng-gen-tp -o $@ $<

  .PHONY: clean
  clean:


What do you think?

Thank you!
Gerlando

(*) As suggested by 
http://redsymbol.net/articles/env-and-python-scripts-version/
