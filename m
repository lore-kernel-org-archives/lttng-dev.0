From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: stack validation warning on lttng-modules bytecode interpreter
Date: Wed, 15 Jun 2016 15:28:06 -0500
Message-ID: <20160615202806.srownowdzh5mexsh@treble>
References: <1074038231.37468.1466009716273.JavaMail.zimbra@efficios.com>
 <20160615181817.vvnf66z6cpwcraq7@treble>
 <734452688.38065.1466018019445.JavaMail.zimbra@efficios.com>
 <20160615193846.qsa7vffhi7rn6x2s@treble>
 <596775805.38201.1466020869401.JavaMail.zimbra@efficios.com>
 <20160615202452.3u4trysvatx4xtgc@treble>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160615202452.3u4trysvatx4xtgc@treble>
Sender: linux-kernel-owner@vger.kernel.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: lttng-dev@lists.lttng.org

On Wed, Jun 15, 2016 at 03:24:52PM -0500, Josh Poimboeuf wrote:
> Thanks, figured it out.  It was an objtool bug.  It was expecting the
> macro to create a section symbol (STT_SECTION), but for some reason this
> file's use of the macro creates a function symbol (STT_FUNC).

Actually, to be precise: this file's use of the macro creates a
relocation which references the function symbol rather than the section
symbol.


-- 
Josh
