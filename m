From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH ust] Add missing --record in Python's
 Makefile
Date: Thu, 15 Oct 2015 21:24:30 +0000 (UTC)
Message-ID: <1709596766.52753.1444944270873.JavaMail.zimbra__19019.0140427605$1444944341$gmane$org@efficios.com>
References: <1444800876-23552-1-git-send-email-simon.marchi@polymtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1Zmq10-0006I3-Qx
 for lttng-dev@lists.lttng.org; Thu, 15 Oct 2015 17:24:47 -0400
In-Reply-To: <1444800876-23552-1-git-send-email-simon.marchi@polymtl.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Simon Marchi <simon.marchi@polymtl.ca>, Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>, Philippe Proulx <philippe.proulx@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi,

Jonathan, Philippe, can you check why this is needed, and help us
expand the changelog a bit with the actual reason why we need this
change ?

Thanks,

Mathieu

----- On Oct 14, 2015, at 1:34 AM, Simon Marchi simon.marchi@polymtl.ca wrote:

> I believe this is missing.  Fixes this error when doing
> 
>  $ make install DESTDIR=/tmp/lttng-ust2
> 
> make[1]: Entering directory
> '/home/simark/src/lttng-ust/liblttng-ust-python-agent'
> if [ "/tmp/lttng-ust2" = "" ]; then \
>	/usr/bin/python setup.py install --prefix=/tmp/lttng-ust --record
>	install_files.txt  --verbose --no-compile ;  \
> else \
>	/usr/bin/python setup.py install --root=/tmp/lttng-ust2 --verbose
>	install_files.txt  --prefix=/tmp/lttng-ust --no-compile ; \
> fi
> invalid command name 'install_files.txt'
> Makefile:713: recipe for target 'install-exec-local' failed
> make[1]: *** [install-exec-local] Error 1
> make[1]: Leaving directory
> '/home/simark/src/lttng-ust/liblttng-ust-python-agent'
> Makefile:594: recipe for target 'install-am' failed
> make: *** [install-am] Error 2
> 
> Signed-off-by: Simon Marchi <simon.marchi@polymtl.ca>
> ---
> liblttng-ust-python-agent/Makefile.am | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/liblttng-ust-python-agent/Makefile.am
> b/liblttng-ust-python-agent/Makefile.am
> index f80b8a3..8bac3fb 100644
> --- a/liblttng-ust-python-agent/Makefile.am
> +++ b/liblttng-ust-python-agent/Makefile.am
> @@ -18,7 +18,7 @@ install-exec-local:
> 	if [ "$(DESTDIR)" = "" ]; then \
> 		$(PYTHON) setup.py install --prefix=$(prefix) --record install_files.txt
> 		--verbose --no-compile $(DISTSETUPOPTS);  \
> 	else \
> -		$(PYTHON) setup.py install --root=$(DESTDIR) --verbose install_files.txt
> --prefix=$(prefix) --no-compile $(DISTSETUPOPTS); \
> +		$(PYTHON) setup.py install --root=$(DESTDIR) --verbose --record
> install_files.txt  --prefix=$(prefix) --no-compile $(DISTSETUPOPTS); \
> 	fi
> clean-local:
> 	rm -rf build
> --
> 2.6.1
> 
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
