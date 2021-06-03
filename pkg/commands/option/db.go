package option

import (
	"github.com/urfave/cli/v2"
	"golang.org/x/xerrors"
)

// DBOption holds the options for trivy DB
type DBOption struct {
	Reset          bool
	DownloadDBOnly bool
	SkipUpdate     bool
	Light          bool
	NoProgress     bool
}

// NewDBOption is the factory method to return the DBOption
func NewDBOption(c *cli.Context) DBOption {
	return DBOption{
		Reset:          c.Bool("reset"),
		DownloadDBOnly: c.Bool("download-db-only"),
		SkipUpdate:     c.Bool("skip-update"),
		Light:          c.Bool("light"),
		NoProgress:     c.Bool("no-progress"),
	}
}

// Init initialize the DBOption
func (c *DBOption) Init() (err error) {
	if c.SkipUpdate && c.DownloadDBOnly {
		return xerrors.New("--skip-update and --download-db-only options can not be specified both")
	}
	return nil
}
