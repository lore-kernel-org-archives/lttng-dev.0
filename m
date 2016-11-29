From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] LTTng-UST 2.9.0 (Linux user-space tracer)
Date: Tue, 29 Nov 2016 22:42:43 +0000 (UTC)
Message-ID: <828273171.20873.1480459363170.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lttng-dev@lists.lttng.org
Cc: linux-kernel <linux-kernel@vger.kernel.org>, diamon-discuss@lists.linuxfoundation.org
List-Id: lttng-dev@lists.lttng.org

This is the official announcement of the release of LTTng-UST 2.9.0.
Release name: Joannès.

LTTng-UST, the Linux Trace Toolkit Next Generation Userspace Tracer,
is a low-overhead application tracer. The library "liblttng-ust" enables
tracing of applications and libraries.

New and Noteworthy for LTTng-UST 2.9:

* Various performance improvements. Tested on x86-64 and ARM32.
* New liblttng-ust-fd helper library to deal with daemon applications
  closing file descriptors that don't belong to them, e.g. loop
  closing file descriptors after fork, or BSD closeall().
* Introduce library load/unlock tracking events, which is more
  precise than the dlopen/dlmopen/dlclose instrumentation we had
  in lttng-ust 2.8 in cases where a dlopen'd library loads its
  own dependencies.
* Tracepoints: new payload types supported: array and sequences of
  integers in network byte order,
* Documentation (man pages) overhaul,
* Added support for ARM64 "aarch64_be" for some toolchains,
* Added "-ust" suffix to lttng-ust thread names,
* Introduce lttng_ust_loaded weak symbol, meant to allow applications
  to detect whether lttng-ust is dynamically loaded,
* perf counters contexts can now be used across all architectures
  supported by Perf. We use a read() system call on a perf file
  descriptor as fallback. It is slower, but works everywhere.

The release name "Joannès" is named after a Berliner Weisse style
beer from the Trèfle Noir microbrewery in Rouyn-Noranda. It is a
tangy beer with a distinct pink dress and intense fruit flavor,
thanks to the presence of fresh blackcurrant grown in Témiscamingue.

Project website: http://lttng.org
Documentation: http://lttng.org/docs
Download link: http://lttng.org/download

Changelog:

2016-11-29 (National Square Dance Day) lttng-ust 2.9.0
        * lttng-ust(3): document `lttng_ust_loaded` symbol
        * lttng-ust(3): document `perf:thread:raw:rN:NAME` context
        * lttng-ust-dl(3): update documentation
        * lttng-ust(3): document liblttng-ust-fd
        * doc/man: document the lttng_ust_lib events
        * doc/man: add full stop to descriptive table cells
        * doc/man: reorganize source for tables
        * lttng-ust(3): sort ctf_*() macro parameter definitions
        * lttng-ust(3): fix alignment and indentation
        * lttng-ust(3): document new ctf_*() array/sequence network/hex macros
        * Performance: add missing "caa_unlikely" on fast-path
        * Fix: loglevel and model_emf_uri build fix
        * Fix: loglevel and model_emf_uri with g++ compiled probes
        * Fix: Out of tree build of liblttng-ust-java

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
