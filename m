From: Hollis Blanchard <hollis_blanchard@mentor.com>
Subject: -warn-common with lttng-ust 2.0.2
Date: Thu, 7 Jun 2012 14:26:22 -0700
Message-ID: <4FD11C7E.7060303__40488.948862958$1339104415$gmane$org@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Hollis_Blanchard@mentor.com>) id 1SckDu-0001Z0-EK
	for lttng-dev@lists.lttng.org; Thu, 07 Jun 2012 17:26:30 -0400
Received: from svr-orw-fem-01.mgc.mentorg.com ([147.34.98.93])
	by relay1.mentorg.com with esmtp
	id 1SckDn-0001Qj-Lk from Hollis_Blanchard@mentor.com
	for lttng-dev@lists.lttng.org; Thu, 07 Jun 2012 14:26:23 -0700
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi, I was adding an LTTng UST 2.0 tracepoint to an application that uses 
-warn-common (see http://www.math.utah.edu/docs/info/ld_2.html). I 
created a simple tracepoint, had lttng-gen-tp produce tracepoints.o, 
then linked that to the application, along with -llttng-ust. This 
results in some warnings:

tracepoints.o: warning: common of `handle' overridden by definition
/usr/local/lib/liblttng-ust.so: warning: defined here
tracepoints.o: warning: common of `lttng_client_callbacks_overwrite' overridden by definition
/usr/local/lib/liblttng-ust.so: warning: defined here
tracepoints.o: warning: common of `lttng_client_callbacks_discard' overridden by definition
/usr/local/lib/liblttng-ust.so: warning: defined here
tracepoints.o: warning: common of `lttng_client_callbacks_metadata' overridden by definition
/usr/local/lib/liblttng-ust.so: warning: defined here
/usr/local/lib/liblttng-ust-tracepoint.so.0: warning: multiple common of `handle'
tracepoints.o: warning: previous common is here

This seems to be a valid warning. The LTTng UST headers contain 
definitions like this in include/lttng/ringbuffer-config.h:
struct lttng_ust_shm_handle *handle;

If two objects use that header, each will get a copy of "handle", right?

-- 
Hollis Blanchard
Mentor Graphics, Embedded Systems Division
