From: Matthew Khouzam <matthew.khouzam@ericsson.com>
Subject: Ctf specification on Variants and Enums
Date: Thu, 5 Dec 2013 17:19:44 -0500
Message-ID: <52A0FC00.8070706__49836.1696525992$1386282121$gmane$org@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from usevmg20.ericsson.net ([198.24.6.45])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <matthew.khouzam@ericsson.com>) id 1VohI4-0003JV-Fd
	for lttng-dev@lists.lttng.org; Thu, 05 Dec 2013 17:21:10 -0500
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi,
In the ctf specifications variants need a tag that is an enum. An enum
can have identifiers as Strings. The enum can contain strings.

so if you have an enum:int32{"a","b","c", d} tag;
and a variant <tag> { int "a"; int "b"... } according to the spec it
should be fine.
according to the test cases it fails.

Please clarify where my logic went astray.

Also, in reading the spec, there are no guaranties that enums contain
ANY values of the fields of the variants. I think this is problematic

enum { a,b,c}
variant{
x,y,z} passes.
