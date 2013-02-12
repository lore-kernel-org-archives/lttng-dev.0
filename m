From: David Smith <dsmith@redhat.com>
Subject: Using lttng-ust's libringbuffer outside lttng-ust
Date: Tue, 12 Feb 2013 13:56:10 -0600
Message-ID: <511A9E5A.4010303@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <systemtap-return-20401-gls-systemtap=m.gmane.org@sourceware.org>
List-Unsubscribe: <mailto:systemtap-unsubscribe-gls-systemtap=m.gmane.org@sourceware.org>
List-Subscribe: <mailto:systemtap-subscribe@sourceware.org>
List-Post: <mailto:systemtap@sourceware.org>
List-Help: <mailto:systemtap-help@sourceware.org>, <http://sourceware.org/lists.html#faqs>
Sender: systemtap-owner@sourceware.org
To: LTTNG Dev <lttng-dev@lists.lttng.org>
Cc: Systemtap List <systemtap@sourceware.org>
List-Id: lttng-dev@lists.lttng.org

Over in systemtap land, we're working on implementing a pure userspace
backend, using a project called dyninst (<http://www.dyninst.org/>). As
part of this work, we need to implement a data channel between
systemtap and the target executable(s). Most of the data (print
statement output) flows from probes run in the target back to systemtap.
There is also a need for a control channel the flows from systemtap to
the systemtap runtime present in the target.

I'm looking into the possibility of using libringbuffer from lttng-ust,
which seems like it might fit our needs. Based on my description above
(feel free to ask for more detail), does using libringbuffer make sense?

Assuming it does make sense, I could use some help. Is there any
documentation that I've missed somewhere that describes libringbuffer in
any detail? I've also looked through the test programs in
'lttng-ust/tests' hoping to find a test for just basic libringbuffer
functionality (a standalone producer/consumer), without much luck. (The
code in 'ust-basic-tracing' and 'ust-multi-test' probably comes the
closest.) I started trying to write such a test, but then realized it
made better sense to ask here first.

The next question would be what is the best way of using libringbuffer
outside lttng-ust. One (not great) possibility would be to just copy the
code into systemtap. Of course the problem there is keeping the code up
to date with changes in lttng-ust. The next possibility would be to make
it a separate project (more like userspace-rcu). A bit of work would be
needed here, since while libringbuffer is mostly self-contained, there
is some use of code from 'lttng-ust/lttng-ust-comm' and
'lttng-ust/snprintf' from 'lttng-ust/libringbuffer'.

Thanks for the help.

-- 
David Smith
dsmith@redhat.com
Red Hat
http://www.redhat.com
256.217.0141 (direct)
256.837.0057 (fax)
