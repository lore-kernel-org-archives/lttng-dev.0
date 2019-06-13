From: Philippe Proulx <eeppeliteloop@gmail.com>
Subject: Re: (no subject)
Date: Thu, 13 Jun 2019 00:06:04 -0400
Message-ID: <CAB4xu_0h-q6En3_hDODbKuXd1=4_e0car73pP8Cf=LNWMKjh_g__37175.4331908718$1560398810$gmane$org@mail.gmail.com>
References: <CABRndgyzXQaYpefcMEMt1ShbqVKaf9vLJOXaL2cgUZMik4=xxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 by lists.lttng.org (Postfix) with ESMTPS id 45PVY62pB6z189T
 for <lttng-dev@lists.lttng.org>; Thu, 13 Jun 2019 00:06:34 -0400 (EDT)
Received: by mail-lf1-x130.google.com with SMTP id r15so13887139lfm.11
 for <lttng-dev@lists.lttng.org>; Wed, 12 Jun 2019 21:06:34 -0700 (PDT)
In-Reply-To: <CABRndgyzXQaYpefcMEMt1ShbqVKaf9vLJOXaL2cgUZMik4=xxw@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Zvi Vered <veredz72@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On Wed, Jun 12, 2019 at 11:22 PM Zvi Vered <veredz72@gmail.com> wrote:
>
> Hello,
>
> I'm trying to read the file "metadata".
> I read the struct:
>
> struct metadata_packet_header {
> uint32_t magic; /* 0x75D11D57 */
> uint8_t  uuid[16]; /* Unique Universal Identifier */
> uint32_t checksum; /* 0 if unused */
> uint32_t content_size; /* in bits */
> uint32_t packet_size; /* in bits */
> uint8_t  compression_scheme; /* 0 if unused */
> uint8_t  encryption_scheme; /* 0 if unused */
> uint8_t  checksum_scheme; /* 0 if unused */
> uint8_t  major; /* CTF spec major version number */
> uint8_t  minor; /* CTF spec minor version number */
> HEADER_END;
> };
>
> the magic is indeed 0x75D11D57.
> What is next struct I should read ?
> I would expect "packet context". Am I right ?
> what struct is it ?
>
> I want to write a simple babeltrace for windows.

Not to discourage you, but I think you're only beginning a very long
journey. Reading a CTF trace entails:

1. Depacketize the metadata stream to get the metadata text.

2. Parse the metadata text to get the appropriate trace, stream, clock,
   and event classes. That's a custom, and somewhat complex,
   domain-specific language called TSDL.

3. Use the classes found in 2. to decode each data stream. This involves
   decoding integer fields with custom sizes (for example, a 27-bit
   unsigned integer field), dynamically finding the lengths of
   sequences and the selectors of variants, updating the stream's clock,
   and much more.

4. Merge the events of the trace's data streams decoded in 3.  to get a
   monotonic sequence of events.

Add to this various fixes for known tracer bugs and support for features
such as trace file rotation and tracing session rotation.

Please don't attempt this.

We are currently polishing the Babeltrace 2 project which does all that,
and much more, for the Linux, macOS, and Windows platforms. Our goal is
to offer a flexible, plugin-based framework to read, manipulate, and
write traces in different formats.

Phil

> If I succeed, and you will find it relevant, I can upload this project.
>
> Thank you in advance,
> Zvika
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
