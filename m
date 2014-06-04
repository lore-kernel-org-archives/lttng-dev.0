From: Gerlando Falauto <gerlando.falauto@keymile.com>
Subject: missing kernel tracing modules
Date: Wed, 04 Jun 2014 15:23:14 +0200
Message-ID: <538F1DC2.80805__12193.8531323851$1401888280$gmane$org@keymile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-de.keymile.com ([195.8.104.250])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <prvs=02326a9719=gerlando.falauto@keymile.com>)
 id 1WsBA3-0007tm-ME
 for lttng-dev@lists.lttng.org; Wed, 04 Jun 2014 09:23:24 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi,

I'm currently trying to use lttng-ust and I don't particularly care 
about kernel tracing, so I'm not even compiling the modules.

So as soon as I create a session I get the following:

root@kmeter1:~# lttng create
Spawning a session daemon
Warning: No tracing group detected
FATAL: Module lttng-tracer not found.
Error: Unable to load module lttng-tracer
FATAL: Module lttng-lib-ring-buffer not found.
Error: Unable to load module lttng-lib-ring-buffer
FATAL: Module lttng-ring-buffer-client-discard not found.
Error: Unable to load module lttng-ring-buffer-client-discard
FATAL: Module lttng-ring-buffer-client-overwrite not found.
Error: Unable to load module lttng-ring-buffer-client-overwrite
FATAL: Module lttng-ring-buffer-metadata-client not found.
Error: Unable to load module lttng-ring-buffer-metadata-client
FATAL: Module lttng-ring-buffer-client-mmap-discard not found.
Error: Unable to load module lttng-ring-buffer-client-mmap-discard
FATAL: Module lttng-ring-buffer-client-mmap-overwrite not found.
Error: Unable to load module lttng-ring-buffer-client-mmap-overwrite
FATAL: Module lttng-ring-buffer-metadata-mmap-client not found.
Error: Unable to load module lttng-ring-buffer-metadata-mmap-client
Error: Unable to remove module lttng-ring-buffer-metadata-mmap-client
Error: Unable to remove module lttng-ring-buffer-client-mmap-overwrite
Error: Unable to remove module lttng-ring-buffer-client-mmap-discard
Error: Unable to remove module lttng-ring-buffer-metadata-client
Error: Unable to remove module lttng-ring-buffer-client-overwrite
Error: Unable to remove module lttng-ring-buffer-client-discard
Error: Unable to remove module lttng-lib-ring-buffer
Error: Unable to remove module lttng-tracer
Warning: No kernel tracer available
Session auto-19700101-000339 created.
Traces will be written in /root/lttng-traces/auto-19700101-000339

As a workaround to get rid of these messages I could manually spawn 
lttng-sessiond with "--no-kernel".
Would it make sense to add such an option to the "lttng" wrapper command 
line, too?
So it could be passed over to lttng-sessiond, should you be aware that 
kernel tracing is not possibile to begin with (and you're not interested 
in it anyway).
What do you think?

Thank you,
Gerlando
