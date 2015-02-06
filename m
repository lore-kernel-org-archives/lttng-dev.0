From: Matthew Khouzam <matthew.khouzam@ericsson.com>
Subject: Parsing external datasources in trace compass for
 regions of interest in a trace
Date: Fri, 6 Feb 2015 17:13:42 -0500
Message-ID: <54D53C96.8030805__23860.2589270615$1423260913$gmane$org@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from usevmg20.ericsson.net ([198.24.6.45])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <matthew.khouzam@ericsson.com>) id 1YJrAL-0005Ap-BM
 for lttng-dev@lists.lttng.org; Fri, 06 Feb 2015 17:14:28 -0500
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: tracecompass developer discussions <tracecompass-dev@eclipse.org>, diamon-discuss@lists.linuxfoundation.org, "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hello,

I am right now looking getting external datasources to supply
information for a trace, like a region of interest.

Background: we can run an analysis on a trace manually, in python, excel
or what have you and come up with something interesting, like: around
12:30pm something happened to a trace. Let's dig deeper with tracecompass.

To make this work: we need to find a way to import the data, so we
should agree on a standard data standard. I personally like the LTTng
analysis outputs so I am picking that for now. :)

Here are some formats that could be acceptable as regions of interest
 * [2015-01-15 12:18:37.216484041, 2015-01-15 12:18:53.821580313] name
 * [2015-01-15 12:18:37.216484041, 2015-01-15 12:18:53.821580313] name
boookmark
 * [ 2015-01-15 12:18:37.216484041] name boookmark
 * [12:18:37.216484041] name boookmark
 * [ 12:18:37.216484041, 12:18:53.821580313] name boookmark
 * [ 2014-12-12 17:29:43.802588035] name with space
 * [ 2014-12-12 17:29:43] irrational title
 * [17:29:43.802588035] rational title
 * [ 17:29:43] test test test
 * [17:29:43,17:29:44] thing
 * [12:18:37.216484041   ] (no text)

When there is one timestamp, we will create one bookmark.
When there is a range, we would create two bookmarks in a given trace,
the first one being appended with " start" the second with " end"

This should allow tracecompass to marginally benefit from the lttng
analyses that are looking pretty nice, and later perhaps from tcp
analyses from tshark and syslog stuff.

Does anyone have an objection to this way of working?
