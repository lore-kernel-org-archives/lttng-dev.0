From: Jesper Derehag <jderehag@hotmail.com>
Subject: singleton tracepoints?
Date: Fri, 24 Apr 2015 08:48:14 +0000
Message-ID: <DUB123-W3249E97F49BFE46B49CB85DDEC0__49120.832529343$1429865378$gmane$org@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from dub004-omc3s6.hotmail.com ([157.55.2.15])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jderehag@hotmail.com>) id 1YlZHY-0004fr-Us
 for lttng-dev@lists.lttng.org; Fri, 24 Apr 2015 04:48:27 -0400
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

I have been thinking a little bit about if there is some way to both define=
/implement and call tracepoints in a single call.

Normally, defining tracepoints goes something along these lines:
1. Define tracepoint in tp.h=A0
=A0 =A0 =A0 =A0 TRACE_EVENT(..)
2. Generate probes in tp.c
=A0 =A0 =A0 =A0&define TRACEPOINT_CREATE_PROBES
=A0 =A0 =A0 =A0&include "tp.h"
3. Call tracepoint in main.c
=A0 =A0 =A0 =A0tracepoint(...);

Obviously you could join points 1&2 if you use=A0lttng-gen-tp. It requires =
that you have a tracepoint definintioin file somewhere.

So the use case would then be to both "define" and call tracepoints in a si=
ngle call.
I was thinking of something like this:

(Bad name, I know..)
singleton_tracepoint(TRACE_WARN, provider, name, const char*, "Something ba=
d has happened!");


So the hard question then, how could we implement this?

I have so far thought of 4 possible approaches (and they are really not ver=
y well thought through, kind of brainstorming here):

1. Continue with the macro-magic as previously used tracepoint-event.h
=A0 =A0 Cant think of any way to make this work. tracepoint-event.h hevaily=
 relies on recursively including itself and the calling tracepoint definiti=
on.
=A0 =A0 To replicate this behavior from inside a function simply wont work,=
 or?

2. Somehow circumvent the "recursive includes from inside a function" probl=
em by utilizing c++ function templates (or possibly lambda functions from c=
++11)
=A0 =A0 Will likely not work either since templates are expanded during com=
pilation and not during preprocessing. So the idea of creating a new scope
=A0 =A0 within the template to create probes will not work either?

3. Re-implement the entire tracepoint callstack
=A0 =A0 Getting a little bit closer, by doing that we can atleast inject tr=
ace packets with the correct formating and so on.
=A0 =A0 But I dont see how one could also maintain the user workflow of bee=
ing able to list probes and so on without having registered it?
=A0 =A0=A0
=A0 =A0 3.1 Lazy register probes
=A0 =A0 =A0 =A0 =A0 If probe was not registered previously (as we pass the =
singleton_tracepoint), register it then.
=A0 =A0 3.2 Never register singleton probes
=A0 =A0 =A0 =A0 =A0 Make it possible to enable unknown tracepoints, perhaps=
 it is already?

4. Extend lttng-gen-tp to also parse src-code for singleton_tracepoints and=
 then generate probes as usual based on the definition.
=A0 =A0 Could maybe be a little bit tricky since you need to do a bit of fu=
zzy parsing (exclude mentions of singleton_tracepoint(..) in comments and s=
o on).
=A0 =A0 But definetly the easiest (and portable) implementation, but would =
significantly add to build times.


Thoughts?

Regards,
Jesper




 		 	   		  =
