From: Simon Marchi <simon.marchi@polymtl.ca>
Subject: Installation of LTTng on the TILEncore-Gx card (TILE-Gx
	processor)
Date: Mon, 11 Feb 2013 20:36:54 -0500
Message-ID: <CAFXXi0kspnh+2aCk+Ar70UR54aJwEY44SoTziS6MBZzmASCWQQ__36406.0658067048$1360633100$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <thundersim@gmail.com>) id 1U54oM-0007IC-4B
	for lttng-dev@lists.lttng.org; Mon, 11 Feb 2013 20:37:30 -0500
Received: by mail-ie0-f182.google.com with SMTP id k14so8574612iea.27
	for <lttng-dev@lists.lttng.org>; Mon, 11 Feb 2013 17:37:24 -0800 (PST)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
Cc: James Tau <jtau@tilera.com>, Chris Metcalf <cmetcalf@tilera.com>
List-Id: lttng-dev@lists.lttng.org

Now that the support for the TileGx architecture is integrated in the
various tools of the LTTng chain, I thought I could reduce the bus
factor and post the installation steps to get LTTng up and running on
this platform. The steps assume that the TILERA_ROOT variable is set
correctly. The version of the Tilera MDE used is 4.1.3.150969 with the
TILEncore-Gx card.

= urcu installation =
$ git clone git://git.lttng.org/userspace-rcu.git
$ ./bootstrap
$ ac_cv_func_malloc_0_nonnull=yes ./configure --host=tile
--prefix=$TILERA_ROOT/tile/usr/local
$ make
$ make install

= lttng-ust installation =
$ git clone git://git.lttng.org/lttng-ust.git
$ ./bootstrap
$ ./configure --host=tile --prefix=$TILERA_ROOT/tile/usr/local
$ make
$ make install

= lttng-tools installation =
$ git clone git://git.lttng.org/lttng-tools.git
$ ./bootstrap
$ ./configure --host=tile --prefix=$TILERA_ROOT/tile/usr/local
--with-consumerd64-bin=/usr/local/lib/lttng/libexec/lttng-consumerd
--with-consumerd64-libdir=/usr/local/lib
$ make
$ make install


By default, /usr/local/lib is not in the dynamic linker's search path,
so you should add it:
$ echo "/usr/local/lib" >> $TILERA_ROOT/tile/etc/ld.so.conf.d/local.conf

You should boot the card using --root so that the filesystem in
$TILERA_ROOT/tile gets loaded on the card:
$ tile-monitor --root

Once on the card, you can set your path to include /usr/local/bin,
update the linker cache and set the path of the session daemon binary:
$ export PATH=$PATH:/usr/local/bin
$ ldconfig
$ LTTNG_SESSIOND_PATH=/usr/local/bin/lttng-sessiond

Now you should be ready to go, I hope I didn't forget any step. Have
fun ust-tracing !

Kernel tracing is a little bit more tricky because the kernel config
shipped by Tilera does not activate tracepoints. There is also a fix
needed to properly load the modules. Let's hope that these two issues
will be resolved in a future version of the MDE. In the meantime, I
can provide the instructions on this list or by personal email if
anybody needs or wants them.

Thanks,

Simon
