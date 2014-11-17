From: Marios-Evaggelos Kogias <marioskogias@gmail.com>
Subject: BlkKin: A GSOC 2014 LTTng project
Date: Mon, 17 Nov 2014 20:53:20 +0100
Message-ID: <CACDi=Kp0REDv=ro+-dRirq9CHYE9iP7cDuNMb_xr698xyN7a1Q__37800.7879284725$1416254044$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yk0-f182.google.com ([209.85.160.182])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <marioskogias@gmail.com>) id 1XqSMZ-0003Cu-VJ
 for lttng-dev@lists.lttng.org; Mon, 17 Nov 2014 14:53:28 -0500
Received: by mail-yk0-f182.google.com with SMTP id 131so1497777ykp.41
 for <lttng-dev@lists.lttng.org>; Mon, 17 Nov 2014 11:53:21 -0800 (PST)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
Cc: Vangelis Koukis <vkoukis@grnet.gr>, Filippos Giannakos <philipgian@grnet.gr>
List-Id: lttng-dev@lists.lttng.org

Hello everyone, my name is Marios Kogias and I was a Google Summer of
Code student working on LTTng this summer under the supervision of
Jeremie Galarneau. In my work I created a tracing infrastructure
backed
by LTTng that implements the Google's Dapper tracing semantics[1] and
is
specially designed for low-overhead applications. Its purpose is to
depict the causal relationships between the different software layers
that a distributed application may have.

To do that I had to implement an instrumentation library which which
wraps LTTng tracepoints and helps the user to instrument C/C++
applications. This information can be visualized using Twitter's
Zipkin[3]. So, I created a pair of Babeltrace plugins to send the
aggregated information to a Scribe server[2]. One of my babeltrace
plugins sends the tracing data created by applications instrumented
with
my library to a Zipkin instance.

A prototype of this work can be found here:
https://github.com/marioskogias/blkin

However, one major thing missing from the above repo is the live
tracing
support, which during the GSOC was implemented in a really hackish
way.
I plan to extend the project when the new plugins systems is
available.
Then, I intend to create probably a Python package for the plugins
which
will have live tracing support as well.

Finally, I need to add that I used this infrastructure to trace Ceph
RADOS. After this attempt I am in close contact with the Ceph
community
since they liked my approach and want to merge BlkKin into their
master
branch for their RADOS tracing support. So, they also expect the next
step in this project.

I am writing here to make my work public and state my intention to
continue working on that until it is something complete and stable.

[1] http://research.google.com/pubs/pub36356.html
[2]https://github.com/facebookarchive/scribe
[3]http://twitter.github.io/zipkin/
