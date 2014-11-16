From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RFC] Addition of layout description and format strings
	to CTF
Date: Sun, 16 Nov 2014 10:32:27 +0000 (UTC)
Message-ID: <168316329.14175.1416133947863.JavaMail.zimbra__983.447340741073$1416134001$gmane$org@efficios.com>
References: <1017583826.14172.1416133885460.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1Xpx8C-0000q6-Ok
 for lttng-dev@lists.lttng.org; Sun, 16 Nov 2014 05:32:34 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id ECA46340108
 for <lttng-dev@lists.lttng.org>; Sun, 16 Nov 2014 10:32:28 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id ITs5OI9c5t9y for <lttng-dev@lists.lttng.org>;
 Sun, 16 Nov 2014 10:32:28 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 6E8DB340152
 for <lttng-dev@lists.lttng.org>; Sun, 16 Nov 2014 10:32:28 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id rS5AvLudpYd5 for <lttng-dev@lists.lttng.org>;
 Sun, 16 Nov 2014 10:32:28 +0000 (UTC)
Received: from evm-mail-1.efficios.com (evm-mail-1.efficios.com [78.47.125.74])
 by mail.efficios.com (Postfix) with ESMTP id 2A12D340108
 for <lttng-dev@lists.lttng.org>; Sun, 16 Nov 2014 10:32:28 +0000 (UTC)
In-Reply-To: <1017583826.14172.1416133885460.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

This document investigates how to best add description of formatting
layout to the Common Trace Format (CTF). The main intent here is to
allow LTTng-UST tracepoint instrumentation to describe how to print the
content of a sequence or array of bytes, so the resulting printout, in
Babeltrace, looks like this:

[...]
000015F0 5F 73 70 72 69 6E 74 66 5F 63 68 6B 00 5F 5F 78 _sprintf_chk.__x
00001600 73 74 61 74 00 6D 65 6D 6D 6F 76 65 00 5F 6F 62 stat.memmove._ob
00001610 73 74 61 63 6B 5F 62 65 67 69 6E 00 62 69 6E 64 stack_begin.bind
[...]

In the spirit of keeping this specification as succinct as possible, an
investigation phase is required before adding this descriptive element
to the Common Trace Format (CTF) specification, since it needs to be
done in a way that is as much as possible general, rather than specific
for this single use-case.

Therefore, this document also investigates how layout description can be
used to describe format strings that express the formatting of events.


Let's consider the description of a CTF TSDL event containing a
sequence:

event {
  name = myevent;
  fields := struct {
    uint32_t len;
    uint8_t myseqfield[len];
  };
};

We could introduce the concept of "type attribute" to CTF, thus adding
a "format" attribute attached to sequence:

event {
  name = myevent;
  fields := struct {
    uint32_t len;
    uint8_t myseqfield[len] __attribute__((format(hexdump)));
  };
};

We however have to take into account that this attribute needs to fit
within the format strings that are about to be added to CTF. In order to
use a similar construct to express the event format strings, we could
also attach them as a "format" attribute of the structure type
describing the event payload. Those may look like:

event {
	name = myevent;
	fields := struct {
		uint64_t field1;
		uint32_t field2;
		uint16_t field3;
		uint32_t len;
		uint8_t myseqfield[len];
	} __attribute__((format(printf("Event has: %d, %x, %d. "
			"Sequence string is %s, hexdump is: %s",
		field1, field2, field3,
		myseqfield,
		myseqfield __attribute__((format(hexdump)))))));
};

Where %d means printing in base 10, signed, %x means printing in base
16, and %s means printing the target field following the field reference
formatter attribute or else the field's own printing format.

This ensures that the format string is expressed as a subset of type
formatting.

In case there are many formatters specified for a field, such as:

event {
	name = myevent;
	fields := struct {
		uint64_t field1 __attribute__((format(printf("%x"))));
	} __attribute__((format(printf("Field hex: %s, dec: %s, dec: %d",
		field1, field1 __attribute__((format(printf("%d")))),
		field1))));
};

The format attribute of the reference always has precedence on the
format attribute of the field it refers to. In the example above, %s
takes the formatter of field1 (printf("%x")), whereas the second
reference to field1 overrides the formatter with a (printf(%d")), to
print it in base 10. The third reference to field1 uses %d directly in
the event structure payload formatter to force a decimal printing of the
field, which has the same result as the second reference.

Attaching the formatter as a type or field reference attribute allows
nesting of print formatting and layout description of nested structures,
arrays, sequences, and variants.

Feedback is welcome!

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
