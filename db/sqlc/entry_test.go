package db

import (
	"context"
	"testing"

	"github.com/stretchr/testify/require"

	"github.com/anaxaim/bank_api/util"
)

func createRandomEntry(accID int64, t *testing.T) Entry {
	arg := CreateEntryParams{
		AccountID: accID,
		Amount:    util.RandomMoney(),
	}

	entry, err := testQueries.CreateEntry(context.Background(), arg)
	require.NoError(t, err)
	require.NotEmpty(t, entry)

	require.Equal(t, arg.AccountID, entry.AccountID)
	require.Equal(t, arg.Amount, entry.Amount)

	require.NotZero(t, entry.ID)
	require.NotZero(t, entry.CreatedAt)

	return entry
}

func TestListEntries(t *testing.T) {
	account1 := createRandomAccount(t)

	for i := 0; i < 10; i++ {
		createRandomEntry(account1.ID, t)
	}

	arg := ListEntriesParams{
		AccountID: account1.ID,
		Limit:     5,
		Offset:    5,
	}

	entries, err := testQueries.ListEntries(context.Background(), arg)
	require.NoError(t, err)
	require.Len(t, entries, 5)

	for _, entry := range entries {
		require.NotEmpty(t, entry)
	}
}
